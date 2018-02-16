Received: from eggs.gnu.org ([2001:4830:134:3::10]:38707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd6A-0003ql-Tv
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Antonios.Motakis@huawei.com>) id 1emd69-0006mY-Ss
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:34 -0500
Received: from lhrrgout.huawei.com ([194.213.3.17]:44264 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Antonios.Motakis@huawei.com>)
	id 1emd69-0006mI-Li
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 05:18:33 -0500
References: <20180208180019.13683-1-antonios.motakis@huawei.com>
	<20180208180019.13683-4-antonios.motakis@huawei.com>
	<20180209161326.653f3468@bahia.lan> <20180209215834.GB3684@flamenco>
From: Antonios Motakis <antonios.motakis@huawei.com>
Message-ID: <b8809b8d-bf56-96e8-c8da-74e741d33931@huawei.com>
Date: Fri, 16 Feb 2018 11:19:43 +0100
MIME-Version: 1.0
In-Reply-To: <20180209215834.GB3684@flamenco>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 3/4] 9pfs: stat_to_qid: use device as input
 to qid.path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>, Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, veaceslav.falico@huawei.com, Eduard.Shishkin@huawei.com, andy.wangguoli@huawei.com, Jani.Kokkonen@huawei.com, berrange@redhat.com, Eric Blake <eblake@redhat.com>



On 02/09/2018 10:58 PM, Emilio G. Cota wrote:
> On Fri, Feb 09, 2018 at 16:13:26 +0100, Greg Kurz wrote:
>> On Thu, 8 Feb 2018 19:00:18 +0100
>> <antonios.motakis@huawei.com> wrote:
> (snip)
>>> +/* creative abuse of tb_hash_func7, which is based on xxhash */
>>> +static uint32_t qpp_hash(QppEntry e)
>>> +{
>>> +    return tb_hash_func7(e.ino_prefix, e.dev, 0, 0, 0);
>> Hmm... Looking at git log include/exec/tb-hash-xx.h, I see that this hash
>> function signature evolved according to TCG needs. It started with 3
>> arguments, then 4 and we have 5 today.
>>
>> So I don't think we should add another unrelated user. Probably best to
>> have our own version. Also it seems it could be simpler since you always
>> pass 0 for the third and later arguments.
> It's fine to use it; the compiler will do the right thing
> with those '0' arguments, because the function is always inlined.
>
> That said, I have some cleanup patches to export this as xxhash and make
> tb_hash a user of it. The patches also remove most of the ugly 0's from
> callers. Those patches will have to wait for a bit though, so for now
> just use tb_hash_func7.

I guess this is why it's a good idea to share patches even if still rough ;)
So I will not worry about this part for now.

>
> (snip)
>>> +        val = g_malloc0(sizeof(QppEntry));
>>> +        if (!val) {
>>> +            return -ENOMEM;
>>> +        }
> g_malloc0 and all other glib memory allocation functions only
> return NULL if the size argument is 0.
> If out of memory, the application is terminated, which is why
> this check is not needed.
> Reference:
>    https://developer.gnome.org/glib/stable/glib-Memory-Allocation.html#glib-Memory-Allocation.description

Thanks for the clarification.

>
> Thanks,
>
> 		Emilio
