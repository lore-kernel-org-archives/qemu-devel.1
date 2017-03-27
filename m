Received: from eggs.gnu.org ([2001:4830:134:3::10]:39133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csXiS-000475-Dj
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1csXiM-0003TW-9C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:42:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1csXiM-0003TI-0P
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 12:41:54 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CBD56A6D4
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 16:41:52 +0000 (UTC)
Date: Mon, 27 Mar 2017 12:41:49 -0400
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170327164149.GI15423@localhost.localdomain>
References: <a438ce0a-3035-1b2e-0d16-296ee930ed35@redhat.com>
	<e6621b99-a980-dc61-b267-590eb08923c0@redhat.com>
	<59a3aed6-e1cf-a601-4369-1a7cd74500cc@redhat.com>
	<20170324035537.GA22342@localhost.localdomain>
	<87fui3yx0y.fsf@dusky.pond.sub.org>
	<20170324124213.GC22342@localhost.localdomain>
	<89101331-9bba-fb6c-42a1-dfce7775fe4c@redhat.com>
	<20170324141025.GE15423@localhost.localdomain>
	<2c25aa1c-3832-e8a6-4bfa-004a79a10c77@redhat.com>
	<87h92ffeg4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h92ffeg4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] [PATCH for-2.9 4/5] rbd: Peel off redundant
 RbdAuthMethod wrapper struct
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, kwolf@redhat.com, jdurgin@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, dillaman@redhat.com

On Mon, Mar 27, 2017 at 07:58:51AM +0200, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > On 03/24/2017 09:10 AM, Jeff Cody wrote:
> >> On Fri, Mar 24, 2017 at 08:49:20AM -0500, Eric Blake wrote:
> >>> On 03/24/2017 07:42 AM, Jeff Cody wrote:
> >>>
> >>>> Agree.  My preference is to leave it as an array of methods, so long as that
> >>>> is tenable to libvirt.
> >>>
> >>> The -drive syntax should remain unchanged (that's an absolute must for
> >>> libvirt).  But the QMP syntax being an array of methods sounds best to
> >>> me, and I think password-secret should be part of the array.  So my vote
> >>> would be for:
> >>>
> >>> { "driver": "rbd", "image": "foo",
> >>>   "auth": [ { "type": "cephx", "password-secret": "sec0" },
> >>>             { "type": "none" } ],
> >>>   "pool": "bar" }
> >>>
> >>> It makes mapping -drive arguments into QMP form a bit trickier, but the
> >>> QMP form is then easily extensible if we add another auth method down
> >>> the road.
> >>>
> >> 
> >> In that case, what about adding user as well, and not just password-secret?
> >
> > Makes sense - anything that is associated solely with cephx should
> > belong to the same flat-union branch for cephx, rather than at the top
> > level.
> 
> I've thought about this some more and have come to the conclusion that
> this design is clumsy and overly complex.  Moreover, I suspect our
> testing has been poor.  Let me explain.
> 
> = Overview =
> 
> What we're trying to configure is authentication methods the client is
> to offer to the server.
> 
> This is not a list, it's a set: the order doesn't matter, and multiple
> entries of the same type make no sense.  We could reject multiple
> entries, or let the last one win silently, but this is just unnecessary
> complexity.
> 
> Type "cephx" uses a user name and a key.
> 
> Type "none" uses neither (it could theoretically use the user name, but
> I've been assured it doesn't).
> 
> The user name defaults to "admin".
> 
> The key defaults to the user name's entry in a keyring.  There is a
> configurable list of key ring files, with a default.  The default
> commonly includes /etc/ceph/client.keyring.
> 

I don't think 'client.keyring' is one of the defaults.  I know
/etc/ceph/keyring is, however.


> = Librados configuration =
> 
> Librados takes these configuration bits as follows:
> 
> * The user name is to be passed to rados_create().  NULL means default
>   to "admin".
> 
> * The key may be passed to rados_conf_set() with key "key" (value is the
>   key) or "keyfile" (value is name of the file containing the key).
>   Documentation discourages use of "key".
> 
> * The list of keyrings may passed to rados_conf_set() with key
>   "keyring" and a value listing file names separated by ','.  At least
>   according to the documentation; the source looks like any non-empty
>   sequence of [;,= \t]* serves as separator.
> 
> * The offered authentication methods may be passed to rados_conf_set()
>   with key "auth_supported" (deprecated) or "auth_client_required", and
>   a value listing methods separated by "," (or maybe [;,= \t]*, see
>   above).  The methods are "cephx" and "none".  Default is "cephx,none".
> 
> = Command line -drive =
> 
> With -drive file=rbd:pool/image[@snapshot][:key=value...], the
> key=value... part lets you specify arbitrary rados_conf_set() settings,
> except pseudo-key "id" is mapped to the user name instead, and
> pseudo-key "conf" names a rados configuration file.  This overloading of
> rados_conf_set() keys and our own pseudo-keys isn't pretty, but it's a
> done deal.  The full set of authentication configuration discussed above
> is available as keys "id", "key", "keyfile", "keyring", "auth_supported"
> and "auth_client_required".  Also via "conf", of course.
> 
> These -drive rbd:...:key=value settings are also available in -drive
> QemuOpts syntax -drive driver=rbd,key=value:
> 
> * Pseudo-key "id" is "user" in QemuOpts.
> 
> * Pseudo-key "conf" is "conf" in QemuOpts, too
> 
> * Any other keys together become "keyvalue-pairs" in QemuOpts, with
>   the same key=value:... syntax.
> 
> Additionally, QemuOpts-only "password-secret" lets you set
> rados_conf_set() key "key" to a value obtained from the QCryptoSecret
> interface.
> 
> Note that @password-secret is a misnomer: this is *not* a password, it's
> a *key*.  Calling it a password is confusing, and makes it harder to
> mentally connect QMP and Ceph configuration.
> 

Good point; @key-secret would be a better name


> The settings in file=rbd:... override the ones in QemuOpts (that's how
> ->bdrv_parse_filename() works), which in turn override (I think)
> settings from a config file.  Note that *any* key other than "id" and
> "conf" in file=rbd:... completely overrides *all* keys in
> "keyvalue-pairs".
> 
> Except "password-secret" works the other way: it overrides "key" set in
> file=rbd:... or "keyvalue-pairs".
> 
> As so often with syntactic sugar, once you actually explain how it
> works, you realize what a bloody mess it is.
> 
> It's not quite clear whether "keyvalue-pairs" is really meant for the
> user, or just for internal use to implement file=rbd:...  I posted a
> patch to hide it from the user.
> 
> = QMP blockdev-add and command line -blockdev =
> 
> The current QAPI/QMP schema lets you specify only a few settings
> directly: pseudo-keys "id" and "conf" (optional members @user and
> @conf), keys "key" and "auth_supported" (optional members
> @password-secret and @auth_supported).  The only way to specify other
> rados_conf_set() settings such as "keyfile" and "keyring" is via "conf".
> 
> Begs the question how the settings you can specify directly interact
> with the config file.  I figure they override the config file.
> 

Yes, looking at the code rados_conf_set() will override both the config
file, and environment variables.


However, certain environment variables will override settings in the
specified "conf" file.  I think "CEPH_KEYRING" is the only one (corresponds
to "keyring"), but I am not sure there are not others.  

This is probably a reason to provide an option for "keyring" via QAPI.

> Let's review how this could be used.
> 
> If you specify no optional members, you get the Ceph defaults described
> above.  Good.
> 
> If you want to override the default user, there's @user.  Good.
> 
> If you want to override the keyring, you have to fall back to @conf.
> Not ideal, but good enough for 2.9.  I guess most users will be fine
> with the default keyrings.
> 

Unless the environment variable CEPH_KEYRING is set, at which point "conf"
won't override it, unless I am missing something.  However, we could either
provide a QAPI interface to set the keyring, or keep a user/key option.


> If you want to override the authentication methods, you have several
> options:
> 
> * Use @conf and set auth_supported (deprecated) or auth_client_required
>   in the config file
> 
> * Use @auth_supported like this:
> 
>       "auth_supported": [ { "auth": METHOD}, ... ]
> 
>   Clumsy.
> 
> If you want to override the key, you again have several options:
> 
> * Use @conf and set keyfile or key in the config file
> 
> * Use @password-secret to get it from the QCryptoSecret interface
> 
>   Did we actually test this?

Yes, and it works.  One caveat: the key obtained from the keyring or
"ceph auth list" are base64 encoded, and qemu_rbd_set_auth() base64 encodes
the key itself into base64.  The rados_conf_set() value for "key" is assumed
to be base64 encoded.  This means the secret file needs to have the key not
base64 encoded, with the current code.


> 
> = What to do for 2.9 =
> 
> I propose to
> 
> * drop both "auth_supported" and "password-secret" from the QAPI schema
> 
> * drop "password-secret" from QemuOpts
> 
> * hide "keyvalue-pairs" in QemuOpts
> 
> No existing usage is affected, since all these things are new in 2.9.
> 
> Users who need something else than the default keyring can continue to
> configure alternate keys and keyrings with -drive, both directly with
> file=rbd:...:key=value and with a config file.  With -blockdev /
> blockdev_add, they need to use the config file.
> 
> We can consider improvements post 2.9.

I am fine with this; the only real functional limitation with dropping this
for 2.9 is that default keyring cannot be overridden in certain scenarios
(it is set via an environment variable, and 'conf' won't override it).


-Jeff
