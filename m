Received: from eggs.gnu.org ([2001:4830:134:3::10]:43570)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9WBb-0008Q1-NU
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1f9WBX-0007I5-Lw
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 09:34:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180405170619.20480-1-kwolf@redhat.com>
	<87d0ywv9j0.fsf@dusky.pond.sub.org>
	<20180418162823.GH4971@localhost.localdomain>
	<20180418163458.GB27579@redhat.com>
	<20180418165208.GI4971@localhost.localdomain>
	<20180418170457.GC27579@redhat.com>
Date: Fri, 20 Apr 2018 15:34:26 +0200
In-Reply-To: <20180418170457.GC27579@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 18 Apr 2018 18:04:57 +0100")
Message-ID: <87y3hixaql.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC][BROKEN] rbd: Allow configuration of
 authentication scheme
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, jdurgin@redhat.com, qemu-block@nongnu.org, jcody@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Apr 18, 2018 at 06:52:08PM +0200, Kevin Wolf wrote:
>> Am 18.04.2018 um 18:34 hat Daniel P. Berrang=C3=A9 geschrieben:
>> > On Wed, Apr 18, 2018 at 06:28:23PM +0200, Kevin Wolf wrote:
>> > > Am 18.04.2018 um 17:06 hat Markus Armbruster geschrieben:
>> >=20
>> > > >     Note that users can still configure authentication methods wit=
h a
>> > > >     configuration file.  They probably do that anyway if they use =
Ceph
>> > > >     outside QEMU as well.
>> > >=20
>> > > This solution that we originally intended to offer was dismissed by
>> > > libvirt as unpractical: libvirt allows the user to specify both a co=
nfig
>> > > file and a key, and if it wanted to use a config file to pass the ke=
y,
>> > > it would have to create a merged config file and keep it sync with t=
he
>> > > user config file at all times. Understandable that they want to avoid
>> > > this.

Yes.

>> > Even if the config file does have auth info setup, we can't assume that
>> > the QEMU VMs are supposed to use the same auth info.

If the user tells you to use this config file, you better assume that's
what he wants.

>> >                                                      In fact to proper=
ly
>> > protect against compromised QEMU, ideally every QEMU would use a compl=
etely
>> > separate RBD user+password, so that compromised QEMU can't then access
>> > RBD disks belonging to a different user.

Yes, unless the user tells you otherwise.

>> > So from libvirt POV we want to pretend the config file does not exist =
at
>> > all and explicitly pass everything that is needed via normal per-disk
>> > setup for blockdev.
>>=20
>> From the rbd driver:
>>=20
>>  * The "conf" option specifies a Ceph configuration file to read.  If
>>  * it is not specified, we will read from the default Ceph locations
>>  * (e.g., /etc/ceph/ceph.conf).  To avoid reading _any_ configuration
>>  * file, specify conf=3D/dev/null.
>>=20
>> So what we actually expected libvirt to do is to create a config file
>> for each rbd image and pass that to qemu. However, libvirt allows the
>> user to specify their own config file and passes that, and therefore
>> doesn't want to create its own config file. If the user doesn't specify
>> a config file, libvirt should probably indeed use /dev/null at least.
>
> Yeah this is a mess - I wish we had never allowed users to pass a config
> file, and had used /dev/null all the time. Unfortunately changing either
> of these aspects would cause backcompat problems for existing deployments
> now :-( So we just have to accept that the global config file is always
> in present, but none the less libvirt should try to specify things as
> fully as possible.

I'm afraid you get backward compatibility problems no matter what.
Whenever you extend libvirt to pass configuration C "via normal per-disk
setup for blockdev", it breaks user config files containing C, doesn't
it?

<heresy>If you're going to break config files on every new feature
anyway, why not break them once and for all, then use them the way we
actually expected libvirt to do.</heresy>
