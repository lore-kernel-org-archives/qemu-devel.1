Received: from eggs.gnu.org ([2001:4830:134:3::10]:46585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIUo-0005Jw-9o
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dqIUl-00065U-5c
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:34:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55626)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dqIUk-00064d-Vz
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 08:34:51 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<87d171fqzd.fsf@dusky.pond.sub.org>
	<426ebb0f-c603-3d1e-2ba0-963875b14394@huawei.com>
Date: Fri, 08 Sep 2017 14:34:46 +0200
In-Reply-To: <426ebb0f-c603-3d1e-2ba0-963875b14394@huawei.com> (Pradeep
	Jagadeesh's message of "Fri, 8 Sep 2017 14:19:16 +0200")
Message-ID: <87bmml8j2x.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, greg kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>

Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> writes:

> On 9/8/2017 12:02 PM, Markus Armbruster wrote:
>> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
[...]
>>> diff --git a/qmp.c b/qmp.c
>>> index b86201e..eed91e5 100644
>>> --- a/qmp.c
>>> +++ b/qmp.c
>>> @@ -130,6 +130,20 @@ void qmp_cpu_add(int64_t id, Error **errp)
>>>      }
>>>  }
>>>
>>> +#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
>>> +
>>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>>> +{
>>> +    return;
>>> +}
>>> +
>>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>>> +{
>>> +    return NULL;
>>> +}
>>> +
>>> +#endif
>>> +
>>>  #ifndef CONFIG_VNC
>>>  /* If VNC support is enabled, the "true" query-vnc command is
>>>     defined in the VNC subsystem */
>>
>> Why do we need *two* stubs for these functions, one here and one in
>> fsdev/qemu-fsdev-dummy.c?
> At two different platforms the build fails. So, there are needed.

We don't add stubs to random places until the linker succeeds for all
the configurations we happen to test.  We figure out *how* the linker
fails to correct our idea of where a certain stub belongs until we find
the one appropriate home for it.

If you can't figure that out, that's okay, just tell us how exactly the
linker fails for you, and we'll be happy to help.
