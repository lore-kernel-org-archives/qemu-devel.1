Received: from eggs.gnu.org ([2001:4830:134:3::10]:41539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGDu7-00073D-4V
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:28:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1fGDu6-0000w5-4t
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:28:27 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:35634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jemmy858585@gmail.com>)
	id 1fGDu6-0000vv-00
	for qemu-devel@nongnu.org; Tue, 08 May 2018 21:28:26 -0400
Received: by mail-io0-x242.google.com with SMTP id g1-v6so31445772iob.2
	for <qemu-devel@nongnu.org>; Tue, 08 May 2018 18:28:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180508141941.GN2500@work-vm>
References: <1525530936-21835-1-git-send-email-lidongchen@tencent.com>
	<1525530936-21835-4-git-send-email-lidongchen@tencent.com>
	<20180508141941.GN2500@work-vm>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 9 May 2018 09:28:24 +0800
Message-ID: <CAOGPPbdp6m9hu-pdBUiQJufhzC==6mWrGaBa1FsoyNAqSVWk+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/6] migration: remove unnecessary
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
Cc: Juan Quintela <quintela@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Gal Shachaf <galsha@mellanox.com>, Aviad Yehezkel <aviadye@mellanox.com>, adido@mellanox.com, Lidong Chen <lidongchen@tencent.com>

On Tue, May 8, 2018 at 10:19 PM, Dr. David Alan Gilbert
<dgilbert@redhat.com> wrote:
> * Lidong Chen (jemmy858585@gmail.com) wrote:
>> Because qio_channel_rdma_writev and qio_channel_rdma_readv maybe invoked
>> by different threads concurrently, this patch removes unnecessary variab=
les
>> len in QIOChannelRDMA and use local variable instead.
>>
>> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
>> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Reviewed-by: Daniel P. Berrang=C3=A9berrange@redhat.com>
>
> Note there's a ' <' missing somehow; minor fix up during commit
> hopefully.
>
> Dave

Sorry for this mistake, I will check more carefully.

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
>> @@ -2640,6 +2639,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel =
*ioc,
>>      int ret;
>>      ssize_t done =3D 0;
>>      size_t i;
>> +    size_t len =3D 0;
>>
>>      CHECK_ERROR_STATE();
>>
>> @@ -2659,10 +2659,10 @@ static ssize_t qio_channel_rdma_writev(QIOChanne=
l *ioc,
>>          while (remaining) {
>>              RDMAControlHeader head;
>>
>> -            rioc->len =3D MIN(remaining, RDMA_SEND_INCREMENT);
>> -            remaining -=3D rioc->len;
>> +            len =3D MIN(remaining, RDMA_SEND_INCREMENT);
>> +            remaining -=3D len;
>>
>> -            head.len =3D rioc->len;
>> +            head.len =3D len;
>>              head.type =3D RDMA_CONTROL_QEMU_FILE;
>>
>>              ret =3D qemu_rdma_exchange_send(rdma, &head, data, NULL, NU=
LL, NULL);
>> @@ -2672,8 +2672,8 @@ static ssize_t qio_channel_rdma_writev(QIOChannel =
*ioc,
>>                  return ret;
>>              }
>>
>> -            data +=3D rioc->len;
>> -            done +=3D rioc->len;
>> +            data +=3D len;
>> +            done +=3D len;
>>          }
>>      }
>>
>> @@ -2768,8 +2768,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *=
ioc,
>>              }
>>          }
>>      }
>> -    rioc->len =3D done;
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
