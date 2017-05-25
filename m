Received: from eggs.gnu.org ([2001:4830:134:3::10]:49796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDvZd-0000FN-Uv
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:25:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <felipe@nutanix.com>) id 1dDvZZ-0008WQ-0j
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:25:17 -0400
Received: from mail-cys01nam02on0121.outbound.protection.outlook.com
	([104.47.37.121]:38752
	helo=NAM02-CY1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <felipe@nutanix.com>) id 1dDvZY-0008Vm-Do
	for qemu-devel@nongnu.org; Thu, 25 May 2017 12:25:12 -0400
From: Felipe Franciosi <felipe@nutanix.com>
Date: Thu, 25 May 2017 16:25:07 +0000
Message-ID: <1867E709-8609-41BF-BB0A-3B851D9D984E@nutanix.com>
References: <1495229390-18909-1-git-send-email-felipe@nutanix.com>
	<869fcc91-40ff-97fa-2a82-ca34695ac864@redhat.com>
In-Reply-To: <869fcc91-40ff-97fa-2a82-ca34695ac864@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0D5D5F92A573454DBA11A52BFAA22E45@namprd02.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] cpus: reset throttle_thread_scheduled
 after sleep
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Malcolm Crossley <malcolm@nutanix.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>


> On 25 May 2017, at 16:52, Paolo Bonzini <pbonzini@redhat.com> wrote:
>=20
>=20
>=20
> On 19/05/2017 23:29, Felipe Franciosi wrote:
>> Currently, the throttle_thread_scheduled flag is reset back to 0 before
>> sleeping (as part of the throttling logic). Given that throttle_timer
>> (well, any timer) may tick with a slight delay, it so happens that under
>> heavy throttling (ie. close or on CPU_THROTTLE_PCT_MAX) the tick may
>> schedule a further cpu_throttle_thread() work item after the flag reset,
>> but before the previous sleep completed. This results on the vCPU thread
>> sleeping continuously for potentially several seconds in a row.
>>=20
>> The chances of that happening can be drastically minimised by resetting
>> the flag after the sleep.
>=20
> True, on the other hand this may also increase the chance of not
> sleeping at all.

The perfect solution (for this throttling strategy) would probably be a per=
-cpu timer. In the meantime, I think avoiding massive sleeps is a win. We o=
bserved stalls in excess of 70 secs at 99% throttle.

> How overcommitted was the host system?

Not overcommitted at all. And it's quite easy to reproduce. All you need is=
 a workload heavy enough to prevent the migration from converging (or a slo=
w network which you can emulate with a qdisc).

With a Linux guest, you should quickly see soft lockups being reported. Wit=
h Windows, probably BSODs.

Thanks,
Felipe

>=20
> Paolo
>=20
>> Signed-off-by: Felipe Franciosi <felipe@nutanix.com>
>> Signed-off-by: Malcolm Crossley <malcolm@nutanix.com>
