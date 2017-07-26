Received: from eggs.gnu.org ([2001:4830:134:3::10]:38227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daJBz-00010k-Vh
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:05:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1daJBv-0001HP-7C
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:05:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56676)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1daJBv-0001HB-1K
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 06:05:19 -0400
References: <201707260928202175266@zte.com.cn>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0295459-5ff2-3efc-412d-a564d8bf980d@redhat.com>
Date: Wed, 26 Jul 2017 12:05:01 +0200
MIME-Version: 1.0
In-Reply-To: <201707260928202175266@zte.com.cn>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH V3] rtc: fix a infinite loop in
 windowsvmstartup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peng.hao2@zte.com.cn
Cc: liu.yi24@zte.com.cn, qemu-devel@nongnu.org, mst@redhat.com

On 26/07/2017 03:28, peng.hao2@zte.com.cn wrote:
>=20
>=20
> when the problem happens , windows kernel is checking  whether REG_A_UI=
P is=20
> changing after periodic timer has stopped. windows kernel access REG_A
> according to INB instrunction and it will spend several microseconds be=
cause
> of VM_EXIT.=20

A vmexit to the RTC timer should be around 10.000 clock cycles, which is
less than a microsecond.

> update timer has changed to a long expire time (as alarm timer)on the
> one hand.
>=20
> on the other hand  244 microseconds in one second is too short to hit
> the region.
>=20
> windows kernel may check REG_A_UIP when considering RTC something wrong=
.
> many windows VM reboot at the same time and rtc periodic timer may dela=
y
> badly..

Does Windows do this test when Hyper-V englightenments are enabled
(especially hv-relaxed)?

It seems to be a Windows issue to me.  I'm not sure adding hacks to the
device model is the right thing to do, especially because I don't
understand why your fix worked.

Paolo
