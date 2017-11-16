Received: from eggs.gnu.org ([2001:4830:134:3::10]:52082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF96z-0001cM-Rf
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 20:37:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF96v-0001Ci-Mv
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 20:37:01 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:11550
	helo=heian.cn.fujitsu.com) by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1eF96v-000176-CI
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 20:36:57 -0500
References: <1510625498-4821-1-git-send-email-jasowang@redhat.com>
	<1510625498-4821-4-git-send-email-jasowang@redhat.com>
	<CAFEAcA_47953-hdHmueXEGXtpxXVOFubJOhzAUh4hsKiYF1ADg@mail.gmail.com>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <d7997eb8-5bb9-775c-159c-26e26c20dabf@cn.fujitsu.com>
Date: Thu, 16 Nov 2017 09:32:45 +0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_47953-hdHmueXEGXtpxXVOFubJOhzAUh4hsKiYF1ADg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 3/8] colo-compare: compare the packet in a
 specified Connection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Zhang Chen <zhangckid@gmail.com>, Li Zhijian <lizhijian@cn.fujitsu.com>


On 11/16/2017 02:57 AM, Peter Maydell wrote:
> On 14 November 2017 at 02:11, Jason Wang <jasowang@redhat.com> wrote:
>> From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>>
>> A package from pri_indev or sec_indev only belongs to a particular
>> Connection, so we only need to compare the package in the specified
>> Connection's primary_list and secondary_list, rather than for each
>> the whole Connection list to compare. This is time-consuming and
>> unnecessary.
>>
>> Less checkpoint more efficiency.
>>
>> Cc: Zhang Chen <zhangckid@gmail.com>
>> Cc: Li Zhijian <lizhijian@cn.fujitsu.com>
>> Cc: Jason Wang <jasowang@redhat.com>
>> Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
>> Signed-off-by: Jason Wang <jasowang@redhat.com>
>> ---
>>  net/colo-compare.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/net/colo-compare.c b/net/colo-compare.c
>> index 54b6347..5d2429b 100644
>> --- a/net/colo-compare.c
>> +++ b/net/colo-compare.c
>> @@ -136,7 +136,7 @@ static int colo_insert_packet(GQueue *queue, Packet *pkt)
>>   * Return 0 on success, if return -1 means the pkt
>>   * is unsupported(arp and ipv6) and will be sent later
>>   */
>> -static int packet_enqueue(CompareState *s, int mode)
>> +static int packet_enqueue(CompareState *s, int mode, Connection **con)
>>  {
>>      ConnectionKey key;
>>      Packet *pkt = NULL;
>> @@ -179,6 +179,7 @@ static int packet_enqueue(CompareState *s, int mode)
>>                           "drop packet");
>>          }
>>      }
>> +    con = &conn;
>>
>>      return 0;
>>  }

Hi, Peter

> Coverity points out that this looks a bit fishy --
> presumably you meant
>   *con = conn;
>

Well，I will fix it right away.

> ? The statement you have now doesn't do anything, since
> 'con' is unused after you change it.

It will be used in colo_compare_connection.

Thanks,
Mao
