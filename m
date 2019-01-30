Received: from eggs.gnu.org ([209.51.188.92]:47902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomdB-0002a6-Mn
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:58:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomd9-0003Nm-QX
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:58:05 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-2-git-send-email-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <567dfcac-165d-5b8b-8179-6a981973111f@redhat.com>
Date: Wed, 30 Jan 2019 10:57:55 +0100
MIME-Version: 1.0
In-Reply-To: <1548841387-7670-2-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 1/5] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>

On 30/01/19 10:43, Thomas Huth wrote:
> CONFIG_SPAPR_RNG should stay in the ppc-softmmu.mak file since this
> is a completely optional device.

What about making it

    default y

and adding to the .mak file this:

#CONFIG_SPAPR_RNG=3Dn

I think the two approaches are more or less equivalent, but
"#CONFIG_FOO=3Dn" has a small advantage when the feature has a build-time
dependency, such as CONFIG_MILKYMIST_TMU2's dependency on OpenGL.  In
that case,

   CONFIG_MILKYMIST_TMU2=3Dy

would report a contradiction if OpenGL is not available at build time, wh=
ile

   default y
   ...
   #CONFIG_MILKYMIST_TMU2=3Dn

would not.

In any case, there are many many such cases in x86 (QXL, HYPERV, FDC,
SEV, ISA_IPMI_*, APPLESMC, SGA, HPET, VTD, AMD_IOMMU, PVPANIC, TPM_TIS,
TPM_CRB) and they should be handled in the same way---and especially
they should be mentioned in the default-configs/ file under "Optional
devices".  So thanks for noticing this case!

Paolo
