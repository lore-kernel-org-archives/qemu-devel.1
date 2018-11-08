Received: from eggs.gnu.org ([2001:4830:134:3::10]:39264)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gKqgU-0002Et-NH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:13:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wainersm@redhat.com>) id 1gKqgR-0007mu-Ek
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:13:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wainersm@redhat.com>) id 1gKqgP-0006CY-7I
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 15:13:43 -0500
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
From: Wainer dos Santos Moschetta <wainersm@redhat.com>
Message-ID: <5086775b-e43f-d24e-3672-cd41561533b6@redhat.com>
Date: Thu, 8 Nov 2018 18:12:54 -0200
MIME-Version: 1.0
In-Reply-To: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RFC/PoC PATCH 0/3] support initrd size up to 4G
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Zhijian <lizhijian@cn.fujitsu.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, zhijianx.li@intel.com, Richard Henderson <rth@twiddle.net>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Under review, the following patch adds acceptance tests for the initrd 
option:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg567776.html

The test should be updated in case this series get merged. Maybe the 
best would be to include those tests along with this series actually.

- Wainer


On 11/08/2018 08:59 AM, Li Zhijian wrote:
> Long long ago, linux kernel have supported up to 4G initrd, but it's header still
> hard code to allow 2G - 1 only.
>   # (Header version 0x0203 or later) the highest safe address for the contents
>   # of an initrd. The current kernel allows up to 4 GB, but leave it at 2 GB to
>   # avoid possible bootloader bugs.
>
> kexec is one of the known scenario which has supported up to 4G initrd.
>
> This patches is to enable up to 4G initrd, Seabios + optionrom(linuxboot_dma)
> works as expected so far.
>
> 3/3 has a huge change of address/memory APIs.
> I replace 'int len' in a stupid way, but it looks not safety.
> $ sed -i 's/int len/uint32_t len/' exec.c
> $ make # and check compiling errors
> $ sed -i 's/int len/uint32_t len/' cpu-all.h
> $ make -i 's/int len/uint32_t len/' include/exec/cpu-common.h
> $ make -i 's/int len/uint32_t len/' include/exec/memory.h
> $ make # all errors gone
>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Peter Crosthwaite <crosthwaite.peter@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
>
> Li Zhijian (3):
>    i386: set initrd_max to 4G - 1 to allow up to 4G initrd
>    change size type from int to int64_t on load_image()
>    change int len to uin32_t len
>
>   exec.c                    | 42 +++++++++++++++++++++---------------------
>   hw/core/loader.c          |  3 ++-
>   hw/i386/pc.c              |  6 ++++++
>   include/exec/cpu-all.h    |  2 +-
>   include/exec/cpu-common.h | 10 +++++-----
>   include/exec/memory.h     | 20 ++++++++++----------
>   6 files changed, 45 insertions(+), 38 deletions(-)
>
