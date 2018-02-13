Received: from eggs.gnu.org ([2001:4830:134:3::10]:57273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elSF2-0004HW-79
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elSEz-0004Xl-2O
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:30:52 -0500
Received: from mail-qt0-x22d.google.com ([2607:f8b0:400d:c0d::22d]:37183)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1elSEy-0004Xc-Ul
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 23:30:49 -0500
Received: by mail-qt0-x22d.google.com with SMTP id d26so692815qtj.4
	for <qemu-devel@nongnu.org>; Mon, 12 Feb 2018 20:30:48 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180213025306.16736-1-linzhecheng@huawei.com>
	<11266f1b-1001-4ddc-173b-7d079b3cc221@amsat.org>
	<D9DE8DBB19F2A24080482022C1DE758302C5A89D@dggemm509-mbx.china.huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c192156d-bba6-152f-84bd-3ffe0a5a8ed8@amsat.org>
Date: Tue, 13 Feb 2018 01:30:45 -0300
MIME-Version: 1.0
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C5A89D@dggemm509-mbx.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiBbUEFUQ0hdIHZob3N0LXVzZXI6IGZp?=
 =?utf-8?q?x_memory_leak?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "mst@redhat.com" <mst@redhat.com>

On 02/13/2018 01:16 AM, linzhecheng wrote:
>> -----邮件原件-----
>> 发件人: Philippe Mathieu-Daudé [mailto:philippe.mathieu.daude@gmail.com]
>> 代表 Philippe Mathieu-Daudé
>> 发送时间: 2018年2月13日 11:54
>> 收件人: linzhecheng <linzhecheng@huawei.com>; qemu-devel@nongnu.org
>> 抄送: pbonzini@redhat.com; wangxin (U) <wangxinxin.wang@huawei.com>;
>> lidonglin <lidonglin@huawei.com>; mst@redhat.com
>> 主题: Re: [Qemu-devel] [PATCH] vhost-user: fix memory leak
>>
>> Hi Linzhecheng,
>>
>> On 02/12/2018 11:53 PM, linzhecheng wrote:
>>> fix memory leak
>>>
>>> Signed-off-by: linzhecheng <linzhecheng@huawei.com>
>>>
>>> diff --git a/net/vhost-user.c b/net/vhost-user.c index
>>> cb45512506..d024573e45 100644
>>> --- a/net/vhost-user.c
>>> +++ b/net/vhost-user.c
>>> @@ -109,6 +109,7 @@ static int vhost_user_start(int queues,
>>> NetClientState *ncs[], CharBackend *be)
>>>  err:
>>>      if (net) {
>>>          vhost_net_cleanup(net);
>>> +        g_free(net);
>>
>> I think this g_free() belongs to vhost_net_cleanup() in net/vhost_net.c:
> I think your qemu version is out of date,  g_free was moved from vhost_net_cleanup in commit e6bcb1b

Now reading e6bcb1b I can understand your patch.

Can you add a reference to this commit in your patch description?

"g_free was moved from vhost_net_cleanup in commit e6bcb1b" might be enough.

Adding reference:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>>
>> void vhost_net_cleanup(struct vhost_net *net) {
>>     vhost_dev_cleanup(&net->dev);
>>     g_free(net);
>> }
>>
>> Regards,
>>
>> Phil.
>>
>>>      }
>>>      vhost_user_stop(i, ncs);
>>>      return -1;
>>>
