Received: from eggs.gnu.org ([2001:4830:134:3::10]:39111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRdOu-0005rG-Bo
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:27:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1gRdDr-0006Nw-Dp
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 08:16:18 -0500
References: <20181127114102.4319-1-david@redhat.com>
	<f31fb9d1-d1dd-7d06-7993-08e44bb77632@de.ibm.com>
	<55d945eb-a9ba-9183-9c47-3a1e505d2d35@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <58cec8ba-8427-235e-c8e5-786360a284c3@redhat.com>
Date: Tue, 27 Nov 2018 14:16:12 +0100
MIME-Version: 1.0
In-Reply-To: <55d945eb-a9ba-9183-9c47-3a1e505d2d35@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Janosch Frank <frankja@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Richard Henderson <rth@twiddle.net>

On 27.11.18 14:06, Thomas Huth wrote:
> On 2018-11-27 13:43, Christian Borntraeger wrote:
>> On 27.11.2018 12:41, David Hildenbrand wrote:
>>> Just like on other architectures, we should stop the clock while the =
guest
>>> is not running. This is already properly done for TCG. Right now, doi=
ng an
>>> offline migration (stop, migrate, cont) can easily trigger stalls in =
the
>>> guest.
>>>
>>> Even doing a
>>>     (hmp) stop
>>>     ... wait 2 minutes ...
>>>     (hmp) cont
>>> will already trigger stalls.
>>>
>>> So whenever the guest stops, backup the KVM TOD. When continuning to =
run
>>> the guest, restore the KVM TOD.
>>
>> We do a similar thing for managedsave so it probably makes sense to so=
lve
>> the stall warnings. Now: At the same time, we actually want to have th=
e guest
>> see the real time and maybe even share the TOD clock with the host in =
some
>> way, while at the same time avoid the stall warnings.
>=20
> Hmm, by the way, do we also have to consider the "-rtc clock=3Dhost|rt|=
vm"
> option from the commandl line, or is this an orthogonal concept?
>=20
>  Thomas
>=20

-rtc [base=3Dutc|localtime|date][,clock=3Dhost|vm][,driftfix=3Dnone|slew]
       Specify base as "utc" or "localtime" to let the RTC start at the c=
urrent UTC or local time, respectively. "localtime" is required for
       correct date in MS-DOS or Windows. To start at a specific point in=
 time, provide date in the format "2006-06-17T16:01:21" or
       "2006-06-17". The default base is UTC.

       By default the RTC is driven by the host system time. This allows =
using of the RTC as accurate reference clock inside the guest,
       specifically if the host time is smoothly following an accurate ex=
ternal reference clock, e.g. via NTP.  If you want to isolate the
       guest time from the host, you can set clock to "rt" instead.  To e=
ven prevent it from progressing during suspension, you can set it to
       "vm".

Most of the stuff here is not supported (should we error out if specified=
?)
and I think this is only considered for the RTC clock on x86, not "ordina=
ry" clocks
(e.g. kvmclock)

--=20

Thanks,

David / dhildenb
