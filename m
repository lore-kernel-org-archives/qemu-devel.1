Received: from eggs.gnu.org ([2001:4830:134:3::10]:59802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLt3y-0005bA-Jr
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dLt3t-0002cF-O6
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:21:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60688)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dLt3t-0002c0-Hv
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 11:21:25 -0400
References: <1497625153-19812-1-git-send-email-thuth@redhat.com>
	<b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <76504ef2-8dd0-ecbc-6e25-55be6abcb14a@redhat.com>
Date: Fri, 16 Jun 2017 17:21:20 +0200
MIME-Version: 1.0
In-Reply-To: <b2343916-49d4-5c18-8b2f-f3538839b46e@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/7] Poison some more target-specific
 defines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 16.06.2017 17:05, Paolo Bonzini wrote:
> On 16/06/2017 16:59, Thomas Huth wrote:
>> This series marks some more #defines as poisoned, which are
>> target-specific (declared in config-target.h) and thus must
>> not be used in common code.
>>
>> v2:
>>  - First two patches are the same as in v1
>>  - Reworked the CONFIG_KVM patches according to Paolo's review feedbac=
k
>>  - Added two new patches to finally poison CONFIG_SOFTMMU, too
>>  - Added a final patch to move bootdevice.o to common-obj now
>>    (based on an earlier patch where I also tried to move numa.o and
>>    balloon.o, too - but these files are indirectly target-dependent as
>>    I now know, so they can't be moved)
>=20
> Why do you say they can't be moved?  They can, and your series should
> change nothing about it, thanks to what you're doing now with
> CONFIG_KVM_IS_POSSIBLE (which was also done before with NEED_CPU_H).

numa.c and balloon.c both use ram_addr_t (numa.c uses it directly, and
balloon.c indirectly via the QEMUBalloonEvent typedef from the header).
And ram_addr_t is currently target-specific - it depends on
CONFIG_XEN_BACKEND. So this could break in certain subtle cases, e.g.
when compiling on a 32-bit host with XEN enabled.

 Thomas
