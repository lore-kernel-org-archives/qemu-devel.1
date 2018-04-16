Received: from eggs.gnu.org ([2001:4830:134:3::10]:35305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f86pL-0007B1-Kj
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:18:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f86pH-0000zO-Ko
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:17:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52428 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1f86pH-0000z5-GE
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 12:17:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1520535787-6223-1-git-send-email-ian.jackson@eu.citrix.com>
	<1520535787-6223-9-git-send-email-ian.jackson@eu.citrix.com>
	<874lkfxfxt.fsf@dusky.pond.sub.org>
	<23252.44539.262716.947319@mariner.uk.xensource.com>
Date: Mon, 16 Apr 2018 18:17:46 +0200
In-Reply-To: <23252.44539.262716.947319@mariner.uk.xensource.com> (Ian
	Jackson's message of "Mon, 16 Apr 2018 15:06:51 +0100")
Message-ID: <87tvsbm8gl.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Ian Jackson <ian.jackson@citrix.com>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, Ian Jackson <ian.jackson@eu.citrix.com>, qemu-devel@nongnu.org, Ross Lagerwall <ross.lagerwall@citrix.com>, xen-devel@lists.xenproject.org, Anthony PERARD <anthony.perard@citrix.com>, Paolo Bonzini <pbonzini@redhat.com>

Ian Jackson <ian.jackson@citrix.com> writes:

> Thanks for the review.  Taking your comments out of order slightly:
>
> Markus Armbruster writes ("Re: [Qemu-devel] [PATCH 08/12] os-posix: Provide new -runas <uid>:<gid> facility"):
>> [change_process_uid] is the only user of @user_pwd, @user_uid, @user_gid.
>> 
>> Have you considered replacing global @user_pwd by @user_uid, @user_gid
>> and @user_name?  --runas with numeric uid and gid would leave @user_name
>> null.
>
> That would defer the getpwnam from argument parsing to os_setup_post.
> I think that's undesriable.

No argument.  But why can't os_parse_cmd_args() call getpwnam() as it
does now, then store user_pwd->pw_uid, ->pw_gid and ->pw_name instead of
user_pwd?  Store a null name when it parses the argument as UID:GID.

>> Ian Jackson <ian.jackson@eu.citrix.com> writes:
>> >  static struct passwd *user_pwd;
>> > +static uid_t user_uid = (uid_t)-1;
>> > +static gid_t user_gid = (gid_t)-1;
>> 
>> As we'll see below, @user_pwd->pw_uid, @user_pwd_pw_gid take precedence
>> over @user_uid, @user_gid.  Awkward.
>
> My patch has the right behaviour: each -runas completely overrides the
> previous one.  -runas that sets user_{uid,gid} always clears user_pwd
> on the way.  So user_pwd can only be set if the most recent -runas was
> a name, and then we should honour the name.
>
> This is rather obscure.  I think you are right that this is confusing.
> It ought to be clearer.
>
> I will
>   - add a comment next to these three variables saying they must
>     all be set at the same time
>   - explicitly (redundantly) clear user_pwd in os_parse_runas_uid_gid
>   - explicitly set user_{uid,gid} to -1 when -runas gets a
>     success from getpwnam
>   - assert in change_process_uid that the combination is legal

Yes, that's better.  But perhaps you like my idea above.

[...]
