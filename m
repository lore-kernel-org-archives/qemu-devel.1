Received: from eggs.gnu.org ([2001:4830:134:3::10]:48001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cKIyy-0001um-EC
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 01:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cKIyu-0005sX-Ew
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 01:05:32 -0500
Received: from [59.151.112.132] (port=7560 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cKIyt-0005n6-M3
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 01:05:28 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
	<0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
	<acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
	<ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
	<0ea03bb4-6aaa-d85f-7441-19e94d80117d@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <e84aeccb-9038-c4db-eb5a-cb1beff7a556@cn.fujitsu.com>
Date: Fri, 23 Dec 2016 14:05:36 +0800
MIME-Version: 1.0
In-Reply-To: <0ea03bb4-6aaa-d85f-7441-19e94d80117d@redhat.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.9 V4 2/2] Add a new qmp command to do
 checkpoint, get replication error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Li Zhijian <lizhijian@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, "eddie . dong" <eddie.dong@intel.com>, Bian Naimeng <biannm@cn.fujitsu.com>, Changlong Xie <xiecl.fnst@cn.fujitsu.com>, Wen Congyang <wencongyang@gmail.com>



On 12/22/2016 08:52 PM, Eric Blake wrote:
> [resend, I don't know how I botched the From: line in my first attempt,
> or if that botch changed who received the mail]
>
> On 12/22/2016 12:08 AM, Zhang Chen wrote:
>>>> Make sense, this command trying to collect status on whether
>>>> an error has occurred, and the "replication_get_error_all(errp)"
>>>> is always succeeds. So, Can you suggest to me the right name?
>>> If replication_get_error_all() always succeeds, then what failure is
>>> possible to be checking for?
>> We can read the errp to check the last error.
> But turning around and reporting an error to the caller is not nice.
> The caller can't distinguish between "I called the command correctly,
> and it is telling me the system has encountered a replication error" and
> "I called the command incorrectly, and it is telling me my usage is
> wrong even though the system has never encountered a replication error".
>   Passing information through errp is NOT the right way to successfully
> report status.
>
>>> Maybe the problem is deeper, in that replication_get_error_all() has an
>>> unusual signature, and needs to be fixed first.  I don't know, and
>>> haven't looked; I'm only coming at this from the user interface
>>> perspective.  But it makes no sense to have a command that queries
>>> whether an error occurred, but where an error having occurred is fatal
>>> (you want the command to successfully report that an error has occurred,
>>> not error out with a second error because a first error was present).
>> Do you means we should fix "void replication_get_error_all()"
>> to "int replication_get_error_all()" first for get the return value?
> Quite possibly yes. But maybe you don't have to do that, and can come up
> with a scheme where only the QMP command wrapper has to be careful.
> Perhaps something like this would work:
>
>>> Then you probably want a query style interface:
>>>
>>> { 'command': 'query-xen-replication-status',
>>>     'returns': 'SomeStruct' }
>>>
>>> where SomeStruct contains details such as status (perhaps an enum that
>>> reports 'normal' or 'error'), and where you are free to add additional
>>> pieces of information that may prove useful later (rather than having to
>>> invent yet more commands that give only a boolean result of success or
>>> failure based on whether the state is normal or in error).
> SomeStruct *qmp_query_xen_replication_status(Error **errp)
> {
>      Error *err = NULL;
>      SomeStruct *result = g_new0(SomeStruct, 1);
>      replication_get_error_all(&err);
>      result.state = err ? SOME_ENUM_ERRORED : SOME_ENUM_NORMAL;
>      error_free(err);
>      /* ... and now you can add additional status items to the API,
>         as needed. errp remains unset, because the command succeeds */
> }

Good idea!
I will fix this in next version.

Thanks
Zhang Chen

>




-- 
Thanks
Zhang Chen
