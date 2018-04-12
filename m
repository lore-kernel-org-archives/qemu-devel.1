Received: from eggs.gnu.org ([2001:4830:134:3::10]:37371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6TMQ-0006v0-MR
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:57:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1f6TMP-00021K-P2
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:57:22 -0400
Received: from mail-io0-x243.google.com ([2607:f8b0:4001:c06::243]:45038)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1f6TMP-000210-Jb
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 23:57:21 -0400
Received: by mail-io0-x243.google.com with SMTP id d7so4792814ioc.11
	for <qemu-devel@nongnu.org>; Wed, 11 Apr 2018 20:57:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180411122923.GE2667@work-vm>
References: <1523089594-1422-1-git-send-email-lidongchen@tencent.com>
	<20180411122923.GE2667@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Thu, 12 Apr 2018 11:57:20 +0800
Message-ID: <CAOGPPbc1b+0raMDrz5jms+8jeLf6T76nXybsmhLN-Eepe-xXfA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/5] Enable postcopy RDMA live migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, adido@mellanox.com, licq@mellanox.com, Lidong Chen <lidongchen@tencent.com>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>

On Wed, Apr 11, 2018 at 8:29 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> Current Qemu RDMA communication does not support send and receive
>> data at the same time, so when RDMA live migration with postcopy
>> enabled, the source qemu return path thread get qemu file error.
>>
>> Those patch add the postcopy support for RDMA live migration.
>
> This description is a little misleading; it doesn't really
> do RDMA during the postcopy phase - what it really does is disable
> the RDMA page sending during the postcopy phase, relying on the
> RDMA codes stream emulation to send the page.

Hi Dave:
    I will modify the description in next version patch.

>
> That's not necessarily a bad fix; you get the nice performance of RDMA
> during the precopy phase, but how bad are you finding the performance
> during the postcopy phase - the RDMA code we have was only really
> designed for sending small commands over the stream?

I have not finished the performance test. There are three choices for RDMA
migration during the postcopy phase.

1. RDMA SEND operation from the source qemu
2. RDMA Write with Immediate from the source qemu
3. RDMA READ from the destination qemu

In theory, RDMA READ from the destination qemu is the best way.
But I think it's better to make choice base on the performance result.
I will send the performance result later.

If use another way during the postcopy phase, it will a big change for the code.
This patch just make postcopy works, and i will send another patch to
improve the performance.

Thanks.

>
> Dave
>
>> Lidong Chen (5):
>>   migration: create a dedicated connection for rdma return path
>>   migration: add the interface to set get_return_path
>>   migration: implement the get_return_path for RDMA iochannel
>>   migration: fix qemu carsh when RDMA live migration
>>   migration: disable RDMA WRITR after postcopy started.
>>
>>  migration/qemu-file-channel.c |  12 ++--
>>  migration/qemu-file.c         |  13 +++-
>>  migration/qemu-file.h         |   2 +-
>>  migration/rdma.c              | 148 ++++++++++++++++++++++++++++++++++++++++--
>>  4 files changed, 163 insertions(+), 12 deletions(-)
>>
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
