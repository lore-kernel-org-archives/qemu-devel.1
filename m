Received: from eggs.gnu.org ([2001:4830:134:3::10]:44543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQV82-0006lq-Uu
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1dQV82-0007Xo-6B
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 04:48:46 -0400
MIME-Version: 1.0
In-Reply-To: <20170627080443.GC14166@lemon.lan>
References: <1496649172-26982-1-git-send-email-ashijeetacharya@gmail.com>
	<1496649172-26982-8-git-send-email-ashijeetacharya@gmail.com>
	<20170627080443.GC14166@lemon.lan>
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 29 Jun 2017 14:18:44 +0530
Message-ID: <CAC2QTZZOc9F=EuPtsmLHv0EXrDfg63O6gsCOt+gH0yp+bO4Nfw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 7/8] vmdk: Update metadata for multiple
 clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

On Tue, Jun 27, 2017 at 1:34 PM, Fam Zheng <famz@redhat.com> wrote:
> On Mon, 06/05 13:22, Ashijeet Acharya wrote:
>> @@ -1876,6 +1942,13 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>          offset += n_bytes;
>>          bytes_done += n_bytes;
>>
>> +        while (m_data->next != NULL) {
>
> If you do
>
>            while (m_data) {
>
>> +            VmdkMetaData *next;
>> +            next = m_data->next;
>> +            g_free(m_data);
>> +            m_data = next;
>> +        }
>> +
>>          /* update CID on the first write every time the virtual disk is
>>           * opened */
>>          if (!s->cid_updated) {
>> @@ -1886,6 +1959,7 @@ static int vmdk_pwritev(BlockDriverState *bs, uint64_t offset,
>>              s->cid_updated = true;
>>          }
>>      }
>> +    g_free(m_data);
>
> then you can remove this line.

As I explained last time, I can't do this because I am reusing the
first allocated m_data. If I am to do it the way you suggest, I will
have to move the allocation of first m_data (m_data =
g_new0(VmdkMetaData, 1)) inside the outer while loop, otherwise things
will segfault.

Ashijeet
