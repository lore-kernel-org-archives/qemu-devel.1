Received: from eggs.gnu.org ([2001:4830:134:3::10]:53156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBuQU-0006jn-8R
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fBuQT-0002s6-Ai
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:52:02 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fBuQT-0002re-5F
	for qemu-devel@nongnu.org; Thu, 26 Apr 2018 23:52:01 -0400
Received: by mail-io0-x241.google.com with SMTP id z4-v6so984780iof.5
	for <qemu-devel@nongnu.org>; Thu, 26 Apr 2018 20:52:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180426164011.GM2631@work-vm>
References: <1524666934-8064-1-git-send-email-lidongchen@tencent.com>
	<1524666934-8064-4-git-send-email-lidongchen@tencent.com>
	<20180426164011.GM2631@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Fri, 27 Apr 2018 11:51:59 +0800
Message-ID: <CAOGPPbcSBxdja0hZLmhqA5y5RBCGjV5-d+ptdGEHh9_CZnWhPQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 3/5] migration: remove unnecessary
 variables len in QIOChannelRDMA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, licq@mellanox.com, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Fri, Apr 27, 2018 at 12:40 AM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoked
>> by different threads concurrently, this patch removes unnecessary variables
>> len in QIOChannelRDMA and use local variable instead.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>
> I'm OK with this patch as is; but now you're making me worried that I
> don't quite understand what thrads are accessing it at the same time; we
> need to document/comment what's accessed concurrently..

for the source qemu, migration thread invokes qio_channel_rdma_writev,
and the return
path thread invokes qio_channel_rdma_readv.

for the destination qemu, before postcopy, the main thread invokes
qio_channel_rdma_readv
and qio_channel_rdma_writev.
after postcopy, the listen_thread invokes qio_channel_rdma_readv, and
the ram_fault_thread
invokes qio_channel_rdma_writev.

>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>
>> ---
>>  migration/rdma.c | 15 +++++++--------
>>  1 file changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/migration/rdma.c b/migration/rdma.c
>> index c745427..f5c1d02 100644
>> --- a/migration/rdma.c
>> +++ b/migration/rdma.c
>> @@ -404,7 +404,6 @@ struct QIOChannelRDMA {
>>      QIOChannel parent;
>>      RDMAContext *rdma;
>>      QEMUFile *file;
>> -    size_t len;
>>      bool blocking; /* XXX we don't actually honour this yet */
>>  };
>>
>> @@ -2640,6 +2639,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>>      int ret;
>>      ssize_t done = 0;
>>      size_t i;
>> +    size_t len = 0;
>>
>>      CHECK_ERROR_STATE();
>>
>> @@ -2659,10 +2659,10 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>>          while (remaining) {
>>              RDMAControlHeader head;
>>
>> -            rioc->len = MIN(remaining, RDMA_SEND_INCREMENT);
>> -            remaining -= rioc->len;
>> +            len = MIN(remaining, RDMA_SEND_INCREMENT);
>> +            remaining -= len;
>>
>> -            head.len = rioc->len;
>> +            head.len = len;
>>              head.type = RDMA_CONTROL_QEMU_FILE;
>>
>>              ret = qemu_rdma_exchange_send(rdma, &head, data, NULL, NULL, NULL);
>> @@ -2672,8 +2672,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
>>                  return ret;
>>              }
>>
>> -            data += rioc->len;
>> -            done += rioc->len;
>> +            data += len;
>> +            done += len;
>>          }
>>      }
>>
>> @@ -2768,8 +2768,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
>>              }
>>          }
>>      }
>> -    rioc->len = done;
>> -    return rioc->len;
>> +    return done;
>>  }
>>
>>  /*
>> --
>> 1.8.3.1
>>
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
