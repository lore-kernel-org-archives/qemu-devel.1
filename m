Received: from eggs.gnu.org ([2001:4830:134:3::10]:42406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f84md-0002et-OZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f84mX-0006HI-Nl
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:07:03 -0400
Received: from smtp03.citrix.com ([162.221.156.55]:59045)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <prvs=6373d119a=Ian.Jackson@citrix.com>)
	id 1f84mX-0006F6-EZ
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 10:06:57 -0400
From: Ian Jackson <ian.jackson@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-ID: <23252.44539.262716.947319@mariner.uk.xensource.com>
Date: Mon, 16 Apr 2018 15:06:51 +0100
In-Reply-To: <874lkfxfxt.fsf@dusky.pond.sub.org>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-9-git-send-email-ian.jackson@eu.citrix.com>
	<874lkfxfxt.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas
 <uid>:<gid> facility
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Juergen Gross <jgross@suse.com>, Stefano  Stabellini <sstabellini@kernel.org>, Ross Lagerwall <ross.lagerwall@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>, Anthony  PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org

Thanks for the review.  Taking your comments out of order slightly:

Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas <uid>:<gid> facility"):
> [change_process_uid] is the only user of @user_pwd, @user_uid, @user_gid.
> 
> Have you considered replacing global @user_pwd by @user_uid, @user_gid
> and @user_name?  --runas with numeric uid and gid would leave @user_name
> null.

That would defer the getpwnam from argument parsing to os_setup_post.
I think that's undesriable.

> Ian Jackson <ian.jackson@eu.citrix.com> writes:
> >  static struct passwd *user_pwd;
> > +static uid_t user_uid = (uid_t)-1;
> > +static gid_t user_gid = (gid_t)-1;
> 
> As we'll see below, @user_pwd->pw_uid, @user_pwd_pw_gid take precedence
> over @user_uid, @user_gid.  Awkward.

My patch has the right behaviour: each -runas completely overrides the
previous one.  -runas that sets user_{uid,gid} always clears user_pwd
on the way.  So user_pwd can only be set if the most recent -runas was
a name, and then we should honour the name.

This is rather obscure.  I think you are right that this is confusing.
It ought to be clearer.

I will
  - add a comment next to these three variables saying they must
    all be set at the same time
  - explicitly (redundantly) clear user_pwd in os_parse_runas_uid_gid
  - explicitly set user_{uid,gid} to -1 when -runas gets a
    success from getpwnam
  - assert in change_process_uid that the combination is legal

> > +    errno = 0;
> > +    rc = qemu_strtoul(optarg, &ep, 0, &lv);
...
> > +    lv = 0;
> 
> Either zero lv before both qemu_strtoul() or neither one.

This is a hangover from the previous version which used raw strtoul.
The assignments to both lv and errno are redundant.

> > -        if (!user_pwd) {
> > -            fprintf(stderr, "User \"%s\" doesn't exist\n", optarg);
> > +        if (!user_pwd && !os_parse_runas_uid_gid(optarg)) {
> > +            error_report("User doesn't exist (and is not <uid>:<gid>)");
> 
> The error message no longer includes the offending value.  Intentional?

I was in two minds.  I will put it back.

> > +    if (user_pwd || user_uid != (uid_t)-1) {
> > +        gid_t intended_gid = user_pwd ? user_pwd->pw_gid : user_gid;
> > +        uid_t intended_uid = user_pwd ? user_pwd->pw_uid : user_uid;
> > +        if (setgid(intended_gid) < 0) {
> > +            fprintf(stderr, "Failed to setgid(%d)\n", intended_gid);
> 
> error_report(), please.  More of the same below.

I was following the existing code in this function.  I'll add a
pre-patch to fix this up here, and maybe a post-patch to fix the rest
of this file.

Thanks,
Ian.
