Received: from eggs.gnu.org ([2001:4830:134:3::10]:57747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcyl-0007yL-Mp
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:00:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRcyj-00080S-TY
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:00:39 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2a028560-064c-b397-a318-0ec279d03a9d@redhat.com>
Date: Tue, 27 Nov 2018 13:59:59 +0100
MIME-Version: 1.0
In-Reply-To: <f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] s390x/tod: properly stop the KVM TOD
 while the guest is not running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27.11.18 13:43, Christian Borntraeger wrote:
> On 27.11.2018 12:41, David Hildenbrand wrote:
>> Just like on other architectures, we should stop the clock while the g=
uest
>> is not running. This is already properly done for TCG. Right now, doin=
g an
>> offline migration (stop, migrate, cont) can easily trigger stalls in t=
he
>> guest.
>>
>> Even doing a
>>     (hmp) stop
>>     ... wait 2 minutes ...
>>     (hmp) cont
>> will already trigger stalls.
>>
>> So whenever the guest stops, backup the KVM TOD. When continuning to r=
un
>> the guest, restore the KVM TOD.
>=20
> We do a similar thing for managedsave so it probably makes sense to sol=
ve
> the stall warnings. Now: At the same time, we actually want to have the=
 guest
> see the real time and maybe even share the TOD clock with the host in s=
ome
> way, while at the same time avoid the stall warnings.

managedsave works right now because we save/restore the TOD. Making the
guest TOD jump is never a good idea. At least not blindly (as you
mention below, special SCLP signals eventually).

>=20
> One idea is to signal the guest on migration (and stop start events) an=
d let
> the guest do a time sync with the host.

Doing so on stop events will most likely kill the ability to debug (e.g.
single step) your guest. You will trap into the SCLP signal handler in
the guest all the time. I don't think this is a good idea for the
general case. It might be for migration. We might instead want to handle
this in KVM directly and not in QEMU.

> In fact, it seems that by architecture we need to signal a special sclp=
 signal=20
> anyway if stsi information would change (e.g. on migration). Maybe we c=
an=20
> piggyback on that and do some time sync interface in the future.

I like the idea but I rather consider it an addon feature and that
shouldn't be the default.

As SCLP documentation is (as far as I know, please correct me if I am
wrong) not publicly available, I suggest going ahead with what I propose
here (what other architectures do) and implementing what you describe on
top later.

Thanks!

--=20

Thanks,

David / dhildenb
