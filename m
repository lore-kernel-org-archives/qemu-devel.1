Received: from eggs.gnu.org ([2001:4830:134:3::10]:34799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cU2oZ-0008Oz-4Q
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 21:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cU2oY-0004cA-DA
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 21:51:03 -0500
References: <1480926904-17596-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1480926904-17596-2-git-send-email-zhang.zhanghailiang@huawei.com>
	<20170113134148.GC10706@stefanha-x1.localdomain>
From: Hailiang Zhang <zhang.zhanghailiang@huawei.com>
Message-ID: <5880296B.7080709@huawei.com>
Date: Thu, 19 Jan 2017 10:50:19 +0800
MIME-Version: 1.0
In-Reply-To: <20170113134148.GC10706@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC v2 1/6] docs/block-replication: Add
 description for shared-disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: xuquan8@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, wency@cn.fujitsu.com, xiecl.fnst@cn.fujitsu.com, Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

On 2017/1/13 21:41, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2016 at 04:34:59PM +0800, zhanghailiang wrote:
>> +Issue qmp command:
>> +  { 'execute': 'blockdev-add',
>> +    'arguments': {
>> +        'driver': 'replication',
>> +        'node-name': 'rep',
>> +        'mode': 'primary',
>> +        'shared-disk-id': 'primary_disk0',
>> +        'shared-disk': true,
>> +        'file': {
>> +            'driver': 'nbd',
>> +            'export': 'hidden_disk0',
>> +            'server': {
>> +                'type': 'inet',
>> +                'data': {
>> +                    'host': 'xxx.xxx.xxx.xxx',
>> +                    'port': 'yyy'
>> +                }
>> +            }
>
> block/nbd.c does have good error handling and recovery in case there is
> a network issue.  There are no reconnection attempts or timeouts that
> deal with a temporary loss of network connectivity.
>
> This is a general problem with block/nbd.c and not something to solve in
> this patch series.  I'm just mentioning it because it may affect COLO
> replication.
>
> I'm sure these limitations in block/nbd.c can be fixed but it will take
> some effort.  Maybe block/sheepdog.c, net/socket.c, and other network
> code could also benefit from generic network connection recovery.
>

Hmm, good suggestion, but IMHO, here, COLO is a little different from
other scenes, if the reconnection method has been implemented,
it still needs a mechanism to identify the temporary loss of network
connection or real broken in network connection.

I did a simple test, just ifconfig down the network card that be used
by block replication, It seems that NBD in qemu doesn't has a ability to
find the connection has been broken, there was no error reports
and COLO just got stuck in vm_stop() where it called aio_poll().

Thanks,
Hailiang



> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
>
