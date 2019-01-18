Received: from eggs.gnu.org ([209.51.188.92]:55314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUgd-0000pt-EG
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:59:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkUgc-0003CN-OO
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:59:55 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:41540)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkUgc-0003Ba-IZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 08:59:54 -0500
Received: by mail-ot1-x344.google.com with SMTP id u16so14414687otk.8
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 05:59:54 -0800 (PST)
MIME-Version: 1.0
References: <20181210112649.11581-1-peter.maydell@linaro.org>
In-Reply-To: <20181210112649.11581-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 13:59:41 +0000
Message-ID: <CAFEAcA-pff8e_X-xkS+ZE1ttJTmnTgD5R2ExmAwsodK7Zc_3dw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] block: fix last
 address-of-packed-member warnings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Ben Warren <ben@skyportsystems.com>, "Michael S. Tsirkin" <mst@redhat.com>, Stefan Weil <sw@weilnetz.de>, "patches@linaro.org" <patches@linaro.org>, Max Reitz <mreitz@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Ping?

thanks
-- PMM

On Mon, 10 Dec 2018 at 11:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset fixes the remaining clang warnings in the block/ code
> about taking the address of a packed struct member, which are all
> in block/vpc and block/vdi code handling UUIDs. Mostly I fix
> these by copying the unaligned field to/from a local variable.
> In the case of qemu_uuid_bswap() I opted to change the API to
> take and return the QemuUUID rather than taking a pointer to it,
> which makes almost all the callsites simpler. This does mean
> a struct copy but the struct is only 16 bytes and I didn't
> judge any of the callsites performance-sensitive enough to care
> about a struct copy of that size.
>
> As usual, tested with "make check" only.
>
> thanks
> -- PMM
>
>
> Peter Maydell (3):
>   block/vpc: Don't take address of fields in packed structs
>   block/vdi: Don't take address of fields in packed structs
>   uuid: Make qemu_uuid_bswap() take and return a QemuUUID
>
>  include/qemu/uuid.h  |  2 +-
>  block/vdi.c          | 54 +++++++++++++++++++++++++++-----------------
>  block/vpc.c          |  4 +++-
>  hw/acpi/vmgenid.c    |  6 ++---
>  tests/vmgenid-test.c |  2 +-
>  util/uuid.c          | 10 ++++----
>  6 files changed, 45 insertions(+), 33 deletions(-)
