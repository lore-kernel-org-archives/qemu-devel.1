Received: from eggs.gnu.org ([2001:4830:134:3::10]:54461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ek9Xi-0004q6-Qg
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:20:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ek9Xe-0003xz-PM
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:20:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:35126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ek9Xe-0003xR-IN
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:20:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ek9Xc-0003JI-6v
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 14:20:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EC5582E80D7
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 14:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 09 Feb 2018 14:08:03 -0000
From: Robert Pasz <1748434@bugs.launchpad.net>
Reply-To: Bug 1748434 <1748434@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151817810596.29573.3248344286701751294.malonedeb@chaenomeles.canonical.com>
Message-Id: <151818528339.10033.6168915766198422064.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1748434] Re: Possibly wrong GICv3 behavior when
 secure enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

see possible solution, in #if 0 is original code in #else see possible
fix

static uint64_t icc_pmr_read(CPUARMState *env, const ARMCPRegInfo *ri)
....
#if 0 // KIURCHER: bug - shall be opposite; see ARM specification
        if (value & 0x80) {
            /* Secure priorities not visible to NS */
            value =3D 0;
        } else if (value !=3D 0xff) {
            value =3D (value << 1) & 0xff;
        }
#else

        if (value & 0x80) {
            value =3D (value << 1) & 0xff;
        } else {
            value =3D 0;
        }
#endif
....


static void icc_pmr_write(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value)
....
#if 0 //KIURCHER: bug
    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env) &&
        (env->cp15.scr_el3 & SCR_FIQ)) {
        /* NS access and Group 0 is inaccessible to NS: return the
         * NS view of the current priority
         */
        if (!(cs->icc_pmr_el1 & 0x80)) {
            /* Current PMR in the secure range, don't allow NS to change it=
 */
            return;
        }
        value =3D (value >> 1) & 0x80;
    }
#else
    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_is_secure(env) &&
        (env->cp15.scr_el3 & SCR_FIQ)) {
        /* NS access and Group 0 is inaccessible to NS: return the
         * NS view of the current priority
         */
        if (!(cs->icc_pmr_el1 & 0x80)) {
            /* Current PMR in the secure range, don't allow NS to change it=
 */
            return;
        }
        value =3D (value >> 1) | 0x80;
    }
#endif

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1748434

Title:
  Possibly wrong GICv3 behavior when secure enabled

Status in QEMU:
  New

Bug description:
  I an tried arm-aarch64 interrupt routing to EL3, by SCR_EL3.FIQ=3D1. Firs=
t I am started QEMU with secure=3Don and GICv3 support.
  I programmed secure and non-secure timers and set-up appropriate interrup=
ts.Secure timer to be GRP1_Secure and non-secure timer to be GRP1_NonSecure=
. ICC_PMR =3D 0xff. Then I switched CPU to EL1. =

  With that setup no interrupt was delivered to PE. GIC interface showed th=
at non secure IRQ is pending. ICC_PMR read at EL1 returns 0 (shall return v=
alue ((PMR_(el3) << 1) & 0xff) according to GIC specification.
  Than I tried to increase interrupt priority mask  - so I set ICC_PMR =3D =
0x7f (at EL3). Then I read at EL1 ICC_PMR=3D0xfe - (is shall be 0). With th=
is setup IRQ of secure timer was taken at EL3, non secure timer didn't rise=
 IRQ (as it is masked by PMR). =

  I dig to qemu code and see wrong condition in file arm_gicv3_cpuif.c in f=
unction  icc_pmr_read(). This behavior is opposite of ARM specification.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1748434/+subscriptions
