Received: from eggs.gnu.org ([2001:4830:134:3::10]:43623)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1drKwy-0002XP-F2
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1drKwu-0007Sn-GB
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:24:16 -0400
Received: from lhrrgout.huawei.com ([194.213.3.17]:23369)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <pradeep.jagadeesh@huawei.com>) id 1drKwu-0007QJ-8Z
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:24:12 -0400
References: <1504541267-36954-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1504541267-36954-6-git-send-email-pradeep.jagadeesh@huawei.com>
	<87d171fqzd.fsf@dusky.pond.sub.org>
	<426ebb0f-c603-3d1e-2ba0-963875b14394@huawei.com>
	<87bmml8j2x.fsf@dusky.pond.sub.org>
From: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
Message-ID: <51ae9f4f-fa74-9348-c355-ecd0566c0017@huawei.com>
Date: Mon, 11 Sep 2017 11:23:05 +0200
MIME-Version: 1.0
In-Reply-To: <87bmml8j2x.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v10 5/6] fsdev: QMP interface for throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Pradeep Jagadeesh <pradeepkiruvale@gmail.com>, alberto garcia <berto@igalia.com>, qemu-devel@nongnu.org, greg kurz <groug@kaod.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, jani kokkonen <jani.kokkonen@huawei.com>

On 9/8/2017 2:34 PM, Markus Armbruster wrote:
> Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com> writes:
>
>> On 9/8/2017 12:02 PM, Markus Armbruster wrote:
>>> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
> [...]
>>>> diff --git a/qmp.c b/qmp.c
>>>> index b86201e..eed91e5 100644
>>>> --- a/qmp.c
>>>> +++ b/qmp.c
>>>> @@ -130,6 +130,20 @@ void qmp_cpu_add(int64_t id, Error **errp)
>>>>      }
>>>>  }
>>>>
>>>> +#if defined(_WIN64) || defined(_WIN32) || defined(__FreeBSD__)
>>>> +
>>>> +void qmp_fsdev_set_io_throttle(IOThrottle *arg, Error **errp)
>>>> +{
>>>> +    return;
>>>> +}
>>>> +
>>>> +IOThrottleList *qmp_query_fsdev_io_throttle(Error **errp)
>>>> +{
>>>> +    return NULL;
>>>> +}
>>>> +
>>>> +#endif
>>>> +
>>>>  #ifndef CONFIG_VNC
>>>>  /* If VNC support is enabled, the "true" query-vnc command is
>>>>     defined in the VNC subsystem */
>>>
>>> Why do we need *two* stubs for these functions, one here and one in
>>> fsdev/qemu-fsdev-dummy.c?
>> At two different platforms the build fails. So, there are needed.
>
> We don't add stubs to random places until the linker succeeds for all
> the configurations we happen to test.  We figure out *how* the linker
> fails to correct our idea of where a certain stub belongs until we find
> the one appropriate home for it.
>
> If you can't figure that out, that's okay, just tell us how exactly the
> linker fails for you, and we'll be happy to help.
If I do not have those stubs in qmp.c.The linking fails when I compile 
like "make docker-test-mingw@fedora"

The stubs in qemu-fsdev-dummy.c required because when I configure on x86 
as --disable-virtfs, then the compilation fails.

So, I need the stubs at both the places. Please let me know if I can 
avoid some how.

Regards,
Pradeep
