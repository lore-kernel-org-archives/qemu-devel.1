Received: from eggs.gnu.org ([2001:4830:134:3::10]:48968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDsFC-0004C8-BX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:56:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fDsF6-0003Jm-Ii
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:56:30 -0400
Received: from 9.mo173.mail-out.ovh.net ([46.105.72.44]:52204)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fDsF6-0003HP-Bc
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:56:24 -0400
Received: from player694.ha.ovh.net (unknown [10.109.105.31])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 82D67BE55B
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 15:56:22 +0200 (CEST)
References: <20180423101433.17759-1-clg@kaod.org>
	<CAFEAcA_1q4+kKunX6_d9N3+6tUFGJRRc5biqn5TqDDmh09-kiw@mail.gmail.com>
	<e2d6b0b9-2402-4c34-305e-ae61ebe10df4@kaod.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <707c783c-0c82-4916-c8b9-0a4d93364386@kaod.org>
Date: Wed, 2 May 2018 15:56:12 +0200
MIME-Version: 1.0
In-Reply-To: <e2d6b0b9-2402-4c34-305e-ae61ebe10df4@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] timer/aspeed: fix vmstate version id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jeffery <andrew@aj.id.au>

> for a romulus-bmc machine, which uses a ARM1176 CPU, you can download this
> image :
> 
>    https://openpower.xyz/job/openbmc-build/distro=ubuntu,target=romulus/lastSuccessfulBuild/artifact/deploy/images/romulus/flash-romulus
> 
> but migration fails :
> 
>   qemu-system-arm: error while loading state for instance 0x0 of device 'cpu'
> 
> There seems to be an issue while reading the CPACR reg.

With a brutal setting of CPACR in cpu_reset, the romulus-bmc machine 
migrates. What would be a more appropriate approach ? 

Thanks,

C.  


@@ -166,6 +166,23 @@ static void arm_cpu_reset(CPUState *s)
 #if defined(CONFIG_USER_ONLY)
         /* Userspace expects access to cp10 and cp11 for FP/Neon */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 4, 0xf);
+#else
+        env->cp15.cpacr_el1 = 0;
+        if (arm_feature(env, ARM_FEATURE_VFP)) {
+            if (!arm_feature(env, ARM_FEATURE_NEON)) {
+                /* ASEDIS [31] bit is RAO/WI */
+                env->cp15.cpacr_el1 |= (1ull << 31);
+            }
+
+            /* VFPv3 and upwards with NEON implement 32 double precision
+             * registers (D0-D31).
+             */
+            if (!arm_feature(env, ARM_FEATURE_NEON) ||
+                    !arm_feature(env, ARM_FEATURE_VFP3)) {
+                /* D32DIS [30] is RAO/WI if D16-31 are not implemented. */
+                env->cp15.cpacr_el1 |= (1ull << 30);
+            }
+        }
 #endif
     }
