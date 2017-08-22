Received: from eggs.gnu.org ([2001:4830:134:3::10]:52764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Cg-0000BX-HS
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dk7Ce-0003ej-RT
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:38 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:37869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1dk7Ce-0003eP-Ln
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 07:18:36 -0400
Received: by mail-ua0-x242.google.com with SMTP id n29so3475354uai.4
	for <qemu-devel@nongnu.org>; Tue, 22 Aug 2017 04:18:36 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wp62fmfk.fsf@dusky.pond.sub.org>
References: <20170727154126.11339-1-marcandre.lureau@redhat.com>
	<20170727154126.11339-22-marcandre.lureau@redhat.com>
	<87wp62fmfk.fsf@dusky.pond.sub.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 22 Aug 2017 13:18:35 +0200
Message-ID: <CAJ+F1CJhg4NkHhMDRaLC19-wPe5DeGV1ZzVQjdY-TjYkEpcJPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 21/26] build-sys: make qemu qapi objects
 per-target
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, QEMU <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

Hi

On Thu, Aug 17, 2017 at 1:44 PM, Markus Armbruster <armbru@redhat.com> wrot=
e:
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>
>> The qapi schema has per-target definitions. Move qapi objects in the
>> per-target build, so they can be configured at compile time.
>
> Suggest something like:
>
>     QAPI can't do target-specific conditionals (the symbols are
>     poisoned), and the work-around is to pretend the target-specific
>     stuff is target-independent, with stubs for the other targets.
>     Makes the target-specifity invisible in introspection.
>
>     To unpoison the symbols, we need to move the generated QAPI code to
>     the per-target build.
>
>> Keep qapi-types.o qapi-visit.o in util-obj as they are necessary for
>> common code, but they will be overwritten during the target link.
>
> --verbose: how are they supposed to even compile in the
> target-independent build once we generate #if defined(TARGET_FOO) into
> them?
>

For common code, they will compile without TARGET_FOO.


>>                                                                   Add
>> some stubs for block events, in code shared by tools & qemu.
>
> Sounds awkward.

I guess the alternative is to make the objects that depend on it per-target=
.

>
>> The following patch will configure the schema to conditionally remove
>> per-target disabled features.
>
> "The following patches", right?

yes, fixed

>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>> ---
>>  stubs/qapi-event.c                 | 74 +++++++++++++++++++++++++++++++=
+++++++
>>  tests/test-qobject-input-visitor.c |  1 -
>>  Makefile.objs                      |  9 +----
>>  Makefile.target                    |  4 +++
>>  stubs/Makefile.objs                |  1 +
>>  trace/Makefile.objs                |  2 +-
>>  6 files changed, 81 insertions(+), 10 deletions(-)
>>  create mode 100644 stubs/qapi-event.c
>>
>> diff --git a/stubs/qapi-event.c b/stubs/qapi-event.c
>> new file mode 100644
>> index 0000000000..9415299f3a
>> --- /dev/null
>> +++ b/stubs/qapi-event.c
>> @@ -0,0 +1,74 @@
>> +#include "qemu/osdep.h"
>> +#include "qapi-event.h"
>> +
>> +void qapi_event_send_device_tray_moved(const char *device, const char *=
id,
>> +                                       bool tray_open, Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_quorum_report_bad(QuorumOpType type, bool has_erro=
r,
>> +                                       const char *error, const char *n=
ode_name,
>> +                                       int64_t sector_num,
>> +                                       int64_t sectors_count, Error **e=
rrp)
>> +{
>> +}
>> +
>> +void qapi_event_send_quorum_failure(const char *reference, int64_t sect=
or_num,
>> +                                    int64_t sectors_count, Error **errp=
)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_job_cancelled(BlockJobType type, const char =
*device,
>> +                                         int64_t len, int64_t offset,
>> +                                         int64_t speed, Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_job_completed(BlockJobType type, const char =
*device,
>> +                                         int64_t len, int64_t offset,
>> +                                         int64_t speed, bool has_error,
>> +                                         const char *error, Error **err=
p)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_job_error(const char *device,
>> +                                     IoOperationType operation,
>> +                                     BlockErrorAction action, Error **e=
rrp)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_job_ready(BlockJobType type, const char *dev=
ice,
>> +                                     int64_t len, int64_t offset, int64=
_t speed,
>> +                                     Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_io_error(const char *device, const char *nod=
e_name,
>> +                                    IoOperationType operation,
>> +                                    BlockErrorAction action, bool has_n=
ospace,
>> +                                    bool nospace, const char *reason,
>> +                                    Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_image_corrupted(const char *device,
>> +                                           bool has_node_name,
>> +                                           const char *node_name,
>> +                                           const char *msg, bool has_of=
fset,
>> +                                           int64_t offset, bool has_siz=
e,
>> +                                           int64_t size, bool fatal,
>> +                                           Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_block_write_threshold(const char *node_name,
>> +                                           uint64_t amount_exceeded,
>> +                                           uint64_t write_threshold,
>> +                                           Error **errp)
>> +{
>> +}
>> +
>> +void qapi_event_send_device_deleted(bool has_device, const char *device=
,
>> +                                    const char *path, Error **errp)
>> +{
>> +}
>
> Yup, awkward.
>
>> diff --git a/tests/test-qobject-input-visitor.c b/tests/test-qobject-inp=
ut-visitor.c
>> index 4da5d02c35..0a9352c5c1 100644
>> --- a/tests/test-qobject-input-visitor.c
>> +++ b/tests/test-qobject-input-visitor.c
>> @@ -1266,7 +1266,6 @@ static void test_visitor_in_qmp_introspect(TestInp=
utVisitorData *data,
>>                                             const void *unused)
>>  {
>>      do_test_visitor_in_qmp_introspect(data, &test_qmp_schema_qlit);
>> -    do_test_visitor_in_qmp_introspect(data, &qmp_schema_qlit);
>>  }
>>
>>  int main(int argc, char **argv)
>
> Either squash this change into PATCH 20, or mention it in the commit
> message.

done

>
> See also my review of PATCH 04.
>
>> diff --git a/Makefile.objs b/Makefile.objs
>> index 24a4ea08b8..2664720f9b 100644
>> --- a/Makefile.objs
>> +++ b/Makefile.objs
>> @@ -2,7 +2,7 @@
>>  # Common libraries for tools and emulators
>>  stub-obj-y =3D stubs/ crypto/
>>  util-obj-y =3D util/ qobject/ qapi/
>> -util-obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
>> +util-obj-y +=3D qapi-types.o qapi-visit.o
>>
>>  chardev-obj-y =3D chardev/
>>
>> @@ -72,13 +72,6 @@ common-obj-y +=3D chardev/
>>  common-obj-$(CONFIG_SECCOMP) +=3D qemu-seccomp.o
>>
>>  common-obj-$(CONFIG_FDT) +=3D device_tree.o
>> -
>> -######################################################################
>> -# qapi
>> -
>> -common-obj-y +=3D qmp-marshal.o
>> -common-obj-y +=3D qmp-introspect.o
>> -common-obj-y +=3D qmp.o hmp.o
>>  endif
>>
>>  #######################################################################
>> diff --git a/Makefile.target b/Makefile.target
>> index 2baec9252f..a97dd056ad 100644
>> --- a/Makefile.target
>> +++ b/Makefile.target
>> @@ -154,6 +154,10 @@ endif
>>
>>  GENERATED_FILES +=3D hmp-commands.h hmp-commands-info.h
>>
>> +obj-y +=3D qmp-introspect.o qapi-types.o qapi-visit.o qapi-event.o
>> +obj-y +=3D qmp-marshal.o qmp-introspect.o
>> +obj-y +=3D qmp.o hmp.o
>> +
>
> Moving so much code from "compile once" to "compile per target" is kind
> of sad.  With the full series applied, I see
>
>     $ wc qapi*c qmp*c
>        1528    3089   34576 qapi-event.c
>        5097    9126  107004 qapi-types.c
>       18848   44862  469514 qapi-visit.c
>       12407   32395  404704 qmp-introspect.c
>        6883   14997  182063 qmp-marshal.c
>       44763  104469 1197861 total
>
> Is there any way to split stuff so we recompile less?  Note that this is
> a valid question even without your patches: changing one little thing in
> the QAPI schema commonly triggers a lengthy recompile.  In large part
> because our undisciplined use of #include.  But also because the
> generator's output is monolithic.
>
> I'm not expecting you to answer this question now, I just want to toss
> it out :)
>

Yes, I also think it's the next logical thing to do. We would benefit
from a modular schema, especially common/target split.

>>  endif # CONFIG_SOFTMMU
>>
>>  # Workaround for http://gcc.gnu.org/PR55489, see configure.
>> diff --git a/stubs/Makefile.objs b/stubs/Makefile.objs
>> index f5b47bfd74..1b2bef99c9 100644
>> --- a/stubs/Makefile.objs
>> +++ b/stubs/Makefile.objs
>> @@ -21,6 +21,7 @@ stub-obj-y +=3D machine-init-done.o
>>  stub-obj-y +=3D migr-blocker.o
>>  stub-obj-y +=3D monitor.o
>>  stub-obj-y +=3D notify-event.o
>> +stub-obj-y +=3D qapi-event.o
>>  stub-obj-y +=3D qtest.o
>>  stub-obj-y +=3D replay.o
>>  stub-obj-y +=3D runstate-check.o
>> diff --git a/trace/Makefile.objs b/trace/Makefile.objs
>> index afd571c3ec..6447729d60 100644
>> --- a/trace/Makefile.objs
>> +++ b/trace/Makefile.objs
>> @@ -56,4 +56,4 @@ util-obj-$(CONFIG_TRACE_SIMPLE) +=3D simple.o
>>  util-obj-$(CONFIG_TRACE_FTRACE) +=3D ftrace.o
>>  util-obj-y +=3D control.o
>>  target-obj-y +=3D control-target.o
>> -util-obj-y +=3D qmp.o
>> +target-obj-y +=3D qmp.o
>



--=20
Marc-Andr=C3=A9 Lureau
