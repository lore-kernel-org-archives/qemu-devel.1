Received: from eggs.gnu.org ([2001:4830:134:3::10]:52594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejQR-0005ur-Hw
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dejQM-0000OW-JA
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:54:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59587)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1dejQM-0000OH-Cy
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:54:30 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499182263-19139-1-git-send-email-pradeep.jagadeesh@huawei.com>
	<1499182263-19139-7-git-send-email-pradeep.jagadeesh@huawei.com>
	<87poddbdxd.fsf@dusky.pond.sub.org>
	<df3f5857-8e4c-51c5-2914-13ea8a6e9db3@huawei.com>
Date: Mon, 07 Aug 2017 16:54:27 +0200
In-Reply-To: <df3f5857-8e4c-51c5-2914-13ea8a6e9db3@huawei.com> (Pradeep
	Jagadeesh's message of "Mon, 7 Aug 2017 11:35:22 +0200")
Message-ID: <87mv7bfmxo.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 6/6] fsdev: QMP interface for throttling
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

> On 7/6/2017 8:47 PM, Markus Armbruster wrote:
>> Pradeep Jagadeesh <pradeepkiruvale@gmail.com> writes:
>>
>>> This patch introduces qmp interfaces for the fsdev
>>> devices. This provides two interfaces one
>>> for querying info of all the fsdev devices. The second one
>>> to set the IO limits for the required fsdev device.
>>>
>>> Signed-off-by: Pradeep Jagadeesh <pradeep.jagadeesh@huawei.com>
>>> ---
>>>  Makefile                    |  4 +++
>>>  fsdev/qemu-fsdev-dummy.c    | 10 ++++++
>>>  fsdev/qemu-fsdev-throttle.c | 76 +++++++++++++++++++++++++++++++++++++=
++-
>>>  fsdev/qemu-fsdev-throttle.h | 13 +++++++
>>>  fsdev/qemu-fsdev.c          | 37 ++++++++++++++++++++
>>>  monitor.c                   |  5 +++
>>>  qapi-schema.json            |  3 ++
>>>  qapi/fsdev.json             | 84 +++++++++++++++++++++++++++++++++++++=
++++++++
>>>  qmp.c                       | 14 ++++++++
>>>  9 files changed, 245 insertions(+), 1 deletion(-)
>>>  create mode 100644 qapi/fsdev.json
>>>
>>> diff --git a/Makefile b/Makefile
>>> index 16a0430..4fd7625 100644
>>> --- a/Makefile
>>> +++ b/Makefile
>>> @@ -416,6 +416,10 @@ qapi-modules =3D $(SRC_PATH)/qapi-schema.json $(SR=
C_PATH)/qapi/common.json \
>>>                 $(SRC_PATH)/qapi/crypto.json $(SRC_PATH)/qapi/rocker.js=
on \
>>>                 $(SRC_PATH)/qapi/trace.json
>>>
>>> +ifdef CONFIG_VIRTFS
>>
>> Uh, qapi-schema.json includes fsdev.json *unconditionally*, doesn't it?
> Yes, I did not find any ways to include with some condition.

Hiding dependencies from Make is unlikely to help.  Please drop the
ifdef.

QAPI doesn't currently support conditional inclusion or any compile-time
conditionals for that matter.  Marc-Andr=C3=A9 is trying to change that:
"[PATCH 00/26] qapi: add #if pre-processor conditions to generated
code".

[...]
