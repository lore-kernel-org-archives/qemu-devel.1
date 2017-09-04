Received: from eggs.gnu.org ([2001:4830:134:3::10]:50921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dor7Q-00068w-M6
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:10:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1dor4w-0004Sb-8O
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:08:48 -0400
Received: from fanzine.igalia.com ([91.117.99.155]:47389)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <berto@igalia.com>) id 1dor4v-0003jz-Rn
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 09:06:14 -0400
From: Alberto Garcia <berto@igalia.com>
In-Reply-To: <4b22589d-8299-e4e6-c2f0-9860ea1d0788@huawei.com>
References: <1504016587-39779-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504016587-39779-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<w51inh58kf0.fsf@maestria.local.igalia.com>
	<4b22589d-8299-e4e6-c2f0-9860ea1d0788@huawei.com>
Date: Mon, 04 Sep 2017 15:05:19 +0200
Message-ID: <w514lsiwr5c.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v8 5/6] fsdev: hmp interface for throttling
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

On Mon 04 Sep 2017 02:22:40 PM CEST, Pradeep Jagadeesh wrote:
>>> +void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
>>> +{
>>> +    Error *err = NULL;
>>> +    IOThrottleList *fsdev_list, *info;
>>> +    fsdev_list = qmp_query_fsdev_io_throttle(&err);
>>> +
>>> +    for (info = fsdev_list; info; info = info->next) {
>>> +        print_fsdev_throttle_config(mon, info->value, err);
>>> +    }
>>> +    qapi_free_IOThrottleList(fsdev_list);
>>> +}
>>
>> I don't think what you're doing with the Error here is right:
>>
>>    - You store the error returned by qmp_query_fsdev_io_throttle().
>>    - You report the error for _every_ fsdev in the list. That doesn't
>>      make much sense.
>>    - Furthermore, if there's an error then fsdev_list should be empty,
>>      so you're not reporting anything (and you're leaking the error).
>>    - Even if the list was not empty, hmp_handle_error() frees the error
>>      after reporting it. Therefore the second item in the list would
>>      try to report an error that has already been freed.
> You mean something like below?
>
> fsdev_list = qmp_query_fsdev_io_throttle(&err);
> if (err) {
>      error_report_err(err);
>      return;
> }

More or less, but there's hmp_handle_error() already, so you should use
it:

   void hmp_info_fsdev_iothrottle(Monitor *mon, const QDict *qdict)
   {
       Error *err = NULL;
       IOThrottleList *fsdev_list, *info;
       fsdev_list = qmp_query_fsdev_io_throttle(&err);

       for (info = fsdev_list; info; info = info->next) {
           print_fsdev_throttle_config(mon, info->value);
       }
       qapi_free_IOThrottleList(fsdev_list);

       hmp_handle_error(mon, &err);
   }

Anyway I just checked that fsdev_get_io_throttle() can never return an
Error, so why don't you remove the Error parameter from there
altogether?

You still need it in qmp_query_fsdev_io_throttle() because that's part
of the API, and hmp_info_fsdev_iothrottle() should have the code to
handle it like the one I just pasted, but fsdev_get_io_throttle() does
not need it, or does it?

Berto
