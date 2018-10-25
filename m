Received: from eggs.gnu.org ([2001:4830:134:3::10]:44262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFmLT-0001PK-Bs
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:35:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ppandit@redhat.com>) id 1gFmI9-0007Vy-Hc
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:31:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41772)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1gFmI7-0007S6-Nh
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 16:31:40 -0400
Date: Fri, 26 Oct 2018 02:01:22 +0530 (IST)
From: P J P <ppandit@redhat.com>
In-Reply-To: <CAFEAcA-6djmjK_x_n5z7cnicdgu+eeJF3QJw4iaCOMDLPkEJ7w@mail.gmail.com>
Message-ID: <nycvar.YSQ.7.76.1810252239320.26372@xnncv>
References: <20181022181035.20104-1-ppandit@redhat.com>
	<CAFEAcA-6djmjK_x_n5z7cnicdgu+eeJF3QJw4iaCOMDLPkEJ7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v1] arm: check bit index before usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu Developers <qemu-devel@nongnu.org>, liqsub1 <liqsub1@163.com>, Moguofang <moguofang@huawei.com>

+-- On Thu, 25 Oct 2018, Peter Maydell wrote --+
| Hi; thanks for this patch. Looking at the SA1110 manual,
| it says that writes to the reserved bits [31:28] are
| ignored. So I think that rather than doing this check
| here, we should do what the strongarm_ppc_* code in the
| same file does -- mask off the high bits for writes to
| the direction and state registers. Then it will not
| be possible for high bits to be set here that cause an
| out-of-range array access.

===
diff --git a/hw/arm/strongarm.c b/hw/arm/strongarm.c
index ec2627374d..dd8c4b1f2e 100644
--- a/hw/arm/strongarm.c
+++ b/hw/arm/strongarm.c
@@ -587,12 +587,12 @@ static void strongarm_gpio_write(void *opaque, hwaddr 
offset,
 
     switch (offset) {
     case GPDR:        /* GPIO Pin-Direction registers */
-        s->dir = value;
+        s->dir = value & 0x3fffff;
         strongarm_gpio_handler_update(s);
         break;
 
     case GPSR:        /* GPIO Pin-Output Set registers */
-        s->olevel |= value;
+        s->olevel |= value & 0x3fffff;
         strongarm_gpio_handler_update(s);
         break;
===

does this seem okay?
 
| Side note: this device is used only in the "collie"
| machine model, which only works via TCG, so this is
| not a security issue, just a bug (which will only be
| visible if the guest is buggy.)

Cool, thank you.
--
Prasad J Pandit / Red Hat Product Security Team
47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
