Received: from eggs.gnu.org ([2001:4830:134:3::10]:43071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJwYO-0006uF-4U
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:08:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJwYJ-0001ZW-3t
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:08:36 -0500
Received: from [59.151.112.132] (port=14861 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1cJwYI-0001Vh-DO
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 01:08:31 -0500
References: <1481856403-23599-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<1481856403-23599-3-git-send-email-zhangchen.fnst@cn.fujitsu.com>
	<7b040d96-15b8-4102-432f-0fb5c3454d79@redhat.com>
	<0b0990d4-4040-3a51-1790-edce9a31a8d3@cn.fujitsu.com>
	<acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Message-ID: <ed8e4268-e515-470c-9e8f-a0194e43100b@cn.fujitsu.com>
Date: Thu, 22 Dec 2016 14:08:33 +0800
MIME-Version: 1.0
In-Reply-To: <acec3060-2325-d92a-8f67-20a8ae1222cc@redhat.com>
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



On 12/21/2016 10:25 PM, Eric Blake wrote:
> On 12/21/2016 12:56 AM, Zhang Chen wrote:
>
>>>>    +void qmp_xen_get_replication_error(Error **errp)
>>>> +    {
>>>> +        replication_get_error_all(errp);
>>>> +    }
>>> Is this trying to cause a replication error, or is it trying to collect
>>> status on whether an error has occurred? The name 'get' usually implies
>>> a query that does not change state, but a query usually needs some way
>>> to return what was queried back to the user, so a void function with no
>>> parameters other than error is odd (either the command succeeds because
>>> there was no error, or the command fails with an error message because
>>> the query had something to get?).
>> Make sense, this command trying to collect status on whether
>> an error has occurred, and the "replication_get_error_all(errp)"
>> is always succeeds. So, Can you suggest to me the right name?
> If replication_get_error_all() always succeeds, then what failure is
> possible to be checking for?

We can read the errp to check the last error.

>
> Maybe the problem is deeper, in that replication_get_error_all() has an
> unusual signature, and needs to be fixed first.  I don't know, and
> haven't looked; I'm only coming at this from the user interface
> perspective.  But it makes no sense to have a command that queries
> whether an error occurred, but where an error having occurred is fatal
> (you want the command to successfully report that an error has occurred,
> not error out with a second error because a first error was present).

Do you means we should fix "void replication_get_error_all()"
to "int replication_get_error_all()" first for get the return value?

>
>>>> +# Since: 2.9
>>>> +##
>>>> +{ 'command': 'xen-get-replication-error' }
>>> So I don't think this is the right name for its signature, but I don't
>>> know what you are trying to accomplish with this command to suggest the
>>> right name.
>> This interface is called to check if error happened in replication.
> Then you probably want a query style interface:
>
> { 'command': 'query-xen-replication-status',
>    'returns': 'SomeStruct' }
>
> where SomeStruct contains details such as status (perhaps an enum that
> reports 'normal' or 'error'), and where you are free to add additional
> pieces of information that may prove useful later (rather than having to
> invent yet more commands that give only a boolean result of success or
> failure based on whether the state is normal or in error).
>

Thanks for your suggestion.
Zhang Chen


-- 
Thanks
Zhang Chen
