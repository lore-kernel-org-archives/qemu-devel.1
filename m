Received: from eggs.gnu.org ([2001:4830:134:3::10]:33878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dp9q4-0008SC-FR
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dp9pv-00084z-0Y
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:08:08 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:33664)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dp9pu-00083v-Kl
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 05:07:58 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <75f2f6f9-7d23-dced-6920-4b0be04876b9@huawei.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-7-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51tw0h7f9t.fsf@maestria.local.igalia.com>
	<75f2f6f9-7d23-dced-6920-4b0be04876b9@huawei.com>
Date: Tue, 05 Sep 2017 11:07:45 +0200
Message-ID: <w51r2vl7btq.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 6/6] fsdev: hmp interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>, Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, eric blake <eblake@redhat.com>, greg kurz <groug@kaod.org>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>, qemu-devel@nongnu.org

On Tue 05 Sep 2017 10:28:02 AM CEST, Pradeep Jagadeesh wrote:
>>> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
>>> +{
>>> +    Error *err = NULL;
>>> +    IOThrottleList *fsdev_list, *info;
>>> +    fsdev_list = qmp_query_fsdev_io_throttle(&err);
>>> +
>>> +    for (info = fsdev_list; info; info = info->next) {
>>> +        print_fsdev_throttle_config(mon, info->value);
>>> +    }
>>> +    qapi_free_IOThrottleList(fsdev_list);
>>> +}
>>
>> You're passing an Error to qmp_query_fsdev_io_throttle() but then you
>> don't handle it. Use hmp_handle_error() as I said in my previous e-mail.
> OK I will handle it.
>>
>> I know that with the current code qmp_query_fsdev_io_throttle() is never
>> going to fail, but that's no reason to declare an Error and then ignore
>> it.

> I need to pass err because the function
> qmp_query_fsdev_io_throttle(Error *) is created by the scripts. So, I
> have to declare and pass it. I do not is there any way to avoid this.

When a function takes an Error ** like qmp_query_fsdev_io_throttle() and
many others do, there are two alternatives:

a) Declare an Error, pass it _and then handle it_ (if you don't handle
   it, you're leaking it):

   Error *err = NULL;
   some_function(&err);
   if (err) {
      /* handle err */
   }

b) Don't declare the Error and pass NULL instead:

   some_function(NULL);

Note that (b) is perfectly valid, but if the function you're calling
tries to set an Error then you won't get it. It's ok if you know what
you're doing (which usually means: you have other way to determine if
the function failed, _or_ you don't care if the function failed).

Here you have no other way to know if qmp_query_fsdev_io_throttle()
fails, so you should choose (a).

I know that at the moment qmp_query_fsdev_io_throttle() can never fail
so in practice this doesn't matter much _now_, but if in the future that
function can fail then your code should be ready to handle it.

Berto
