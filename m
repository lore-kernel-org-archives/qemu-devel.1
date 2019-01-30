Received: from eggs.gnu.org ([209.51.188.92]:52705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomtp-0004Iz-2W
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:15:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gomto-0004qB-Ao
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 05:15:17 -0500
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
	<1548841387-7670-2-git-send-email-thuth@redhat.com>
	<567dfcac-165d-5b8b-8179-6a981973111f@redhat.com>
	<723095a0-c4ac-29e4-c540-8bf195789516@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3a7a79eb-b824-eac0-0685-77d0d4e6b79f@redhat.com>
Date: Wed, 30 Jan 2019 11:15:08 +0100
MIME-Version: 1.0
In-Reply-To: <723095a0-c4ac-29e4-c540-8bf195789516@redhat.com>
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

On 30/01/19 11:02, Thomas Huth wrote:
>> I think the two approaches are more or less equivalent, but
>> "#CONFIG_FOO=3Dn" has a small advantage when the feature has a build-t=
ime
>> dependency, such as CONFIG_MILKYMIST_TMU2's dependency on OpenGL.  In
>> that case,
>>
>>    CONFIG_MILKYMIST_TMU2=3Dy
>>
>> would report a contradiction if OpenGL is not available at build time,=
 while
>>
>>    default y
>>    ...
>>    #CONFIG_MILKYMIST_TMU2=3Dn
>>
>> would not.
> I somehow dislike the idea of adding lines that are commented out by
> default. For example, if someone later renames or removes the config
> switch in the Kconfig files, the comment could stay there without being
> noticed, while a CONFIG_XXX=3Dy would cause a clean build failure if th=
e
> option is not available anymore.

I agree.  On the other hand I don't see another solution for the
MILKYMIST_TMU2 and QXL cases, and consistency is a plus too.

How often are config switches renamed or removed, especially
user-visible optional devices though?  I see CONFIG_MEM_DEVICE,
CONFIG_PCI_APB, CONFIG_LIBDECNUMBER, CONFIG_XEN_I386,
CONFIG_MIPS_BOSTON, CONFIG_PIIX_PCI, CONFIG_ISA_MMIO, CONFIG_ICC_BUS
over the last few years but none probably would have been optional
devices in default-configs/ but rather in Kconfig files.

(Long term default-configs/ should probably be built automatically,
possibly by adding a description field to the Kconfig files, and that
would also ameliorate the issue you describe).

Paolo
