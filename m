Received: from eggs.gnu.org ([2001:4830:134:3::10]:57165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3jzq-0003So-6l
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1d3jzk-00039t-NF
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:02:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53538)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1d3jzk-00039M-HA
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 10:02:08 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1493282486-28338-1-git-send-email-armbru@redhat.com>
	<1493282486-28338-5-git-send-email-armbru@redhat.com>
	<CAJ+F1CL2=cjEJ40tJ0nKtWD=DbG9aAmFkoRDT2y0+zaHFZbe0w@mail.gmail.com>
	<8760hqceh7.fsf@dusky.pond.sub.org>
	<CAJ+F1CL=BH2wqKMi3U0iZp4ujw_kHAGszL3KXJHJp9+mF3fmXg@mail.gmail.com>
	<87lgqm83yl.fsf@dusky.pond.sub.org>
	<ef786534-615d-da52-e506-78a0a413f18d@redhat.com>
Date: Thu, 27 Apr 2017 16:02:05 +0200
In-Reply-To: <ef786534-615d-da52-e506-78a0a413f18d@redhat.com> (Eric Blake's
	message of "Thu, 27 Apr 2017 08:13:13 -0500")
Message-ID: <878tmm2bky.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 4/4] qobject-input-visitor: Catch misuse of
 end_struct vs. end_list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Eric Blake <eblake@redhat.com> writes:

> On 04/27/2017 06:50 AM, Markus Armbruster wrote:
>
>>>>>
>>>>> It would be more obvious with a check for qobject_type(tos->obj), no?
>>>>
>>>> --verbose?
>>>>
>>>
>>> Instead of assert(tos->h) assert(qobject_type(tos->obj) == QTYPE_QDICT) ?
>> 
>> The two conditions imply each other.  We can assert either one, or even
>> both.  Eric, got a preference?
>
> Asserting both might make it easier to come up to speed when reading the
> code a year from now.

All right, squashing this:

diff --git a/qapi/qobject-input-visitor.c b/qapi/qobject-input-visitor.c
index 68a6742..d0f0002 100644
--- a/qapi/qobject-input-visitor.c
+++ b/qapi/qobject-input-visitor.c
@@ -296,7 +296,7 @@ static void qobject_input_end_struct(Visitor *v, void **obj)
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
-    assert(tos->h);
+    assert(qobject_type(tos->obj) == QTYPE_QDICT && tos->h);
     qobject_input_pop(v, obj);
 }
 
@@ -360,7 +360,7 @@ static void qobject_input_end_list(Visitor *v, void **obj)
     QObjectInputVisitor *qiv = to_qiv(v);
     StackObject *tos = QSLIST_FIRST(&qiv->stack);
 
-    assert(!tos->h);
+    assert(qobject_type(tos->obj) == QTYPE_QLIST && !tos->h);
     qobject_input_pop(v, obj);
 }
 
