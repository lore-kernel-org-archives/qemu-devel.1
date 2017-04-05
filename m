Received: from eggs.gnu.org ([2001:4830:134:3::10]:59916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvnwl-0000sK-CR
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:38:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cvnwj-0006BC-IA
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:38:15 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:34105)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cvnwj-0006B4-61
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 12:38:13 -0400
Received: by mail-lf0-x243.google.com with SMTP id x137so1639693lff.1
	for <qemu-devel@nongnu.org>; Wed, 05 Apr 2017 09:38:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJ+F1C+2x=0pZxMz8FgxbkQD59zM2pngHKv7AT-hv-KA6xjN+Q@mail.gmail.com>
References: <20170311132256.22951-1-marcandre.lureau@redhat.com>
	<20170311132256.22951-18-marcandre.lureau@redhat.com>
	<20170405161256.GA25291@redhat.com>
	<CAJ+F1C+2x=0pZxMz8FgxbkQD59zM2pngHKv7AT-hv-KA6xjN+Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 5 Apr 2017 20:38:09 +0400
Message-ID: <CAJ+F1CLScc+afY+p6AV76WJxbFRVvEJDRTtKYEXwJ_eRaMu65A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 17/21] virtio-channel: parse qga stream for
 VMDUMP_INFO event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, lersek@redhat.com, mdroth@linux.vnet.ibm.com, armbru@redhat.com, pbonzini@redhat.com, anderson@redhat.com

Hi

Le 5 avr. 2017 18:13, "Daniel P. Berrange" <berrange@redhat.com> a =C3=A9cr=
it :

On Sat, Mar 11, 2017 at 05:22:52PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> On virtio channel "org.qemu.guest_agent.0", parse the json stream until
> the VMDUMP_INFO is received and retrieve the dump details.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  include/sysemu/dump-info.h | 15 +++++++++++++
>  dump.c                     |  3 +++
>  hw/char/virtio-console.c   | 53 ++++++++++++++++++++++++++++++
++++++++++++++++
>  3 files changed, 71 insertions(+)
>  create mode 100644 include/sysemu/dump-info.h
>
> diff --git a/include/sysemu/dump-info.h b/include/sysemu/dump-info.h
> new file mode 100644
> index 0000000000..fb1ddff9af
> --- /dev/null
> +++ b/include/sysemu/dump-info.h
> @@ -0,0 +1,15 @@
> +#ifndef DUMP_INFO_H
> +#define DUMP_INFO_H
> +
> +typedef struct DumpInfo {
> +    bool received;
> +    bool has_phys_base;
> +    uint64_t phys_base;
> +    bool has_text;
> +    uint64_t text;
> +    char *vmcoreinfo;
> +} DumpInfo;
> +
> +extern DumpInfo dump_info;
> +
> +#endif /* DUMP_INFO_H */
> diff --git a/dump.c b/dump.c
> index f7b80d856b..68b406459e 100644
> --- a/dump.c
> +++ b/dump.c
> @@ -20,6 +20,7 @@
>  #include "monitor/monitor.h"
>  #include "sysemu/kvm.h"
>  #include "sysemu/dump.h"
> +#include "sysemu/dump-info.h"
>  #include "sysemu/sysemu.h"
>  #include "sysemu/memory_mapping.h"
>  #include "sysemu/cpus.h"
> @@ -38,6 +39,8 @@
>  #define ELF_MACHINE_UNAME "Unknown"
>  #endif
>
> +DumpInfo dump_info =3D { 0, };
> +
>  uint16_t cpu_to_dump16(DumpState *s, uint16_t val)
>  {
>      if (s->dump_info.d_endian =3D=3D ELFDATA2LSB) {
> diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
> index 798d9b69fd..796b7c85aa 100644
> --- a/hw/char/virtio-console.c
> +++ b/hw/char/virtio-console.c
> @@ -16,6 +16,9 @@
>  #include "trace.h"
>  #include "hw/virtio/virtio-serial.h"
>  #include "qapi-event.h"
> +#include "qapi/qmp/json-streamer.h"
> +#include "qapi/qmp/json-parser.h"
> +#include "sysemu/dump-info.h"
>
>  #define TYPE_VIRTIO_CONSOLE_SERIAL_PORT "virtserialport"
>  #define VIRTIO_CONSOLE(obj) \
> @@ -26,6 +29,7 @@ typedef struct VirtConsole {
>
>      CharBackend chr;
>      guint watch;
> +    JSONMessageParser parser;
>  } VirtConsole;
>
>  /*
> @@ -49,6 +53,11 @@ static ssize_t flush_buf(VirtIOSerialPort *port,
>      VirtConsole *vcon =3D VIRTIO_CONSOLE(port);
>      ssize_t ret;
>
> +    if (vcon->parser.emit &&
> +        !dump_info.received) {
> +        json_message_parser_feed(&vcon->parser, (const char *)buf, len);
> +    }

[snip]

so we just continually feed data into the json parser until we see the
event we care about....

What kind of denial of service protection does our JSON parser have. Now
that QEMU is directly parsing JSON from QEMU guest agent, it is exposed
to malicious attack by the guest agent.

eg what happens if the 'vmcoreinfo' string in the JSON doc received from
the guest ends up being 10GB in size ? Is that going to cause our JSON
parser to allocate QString which is 10GB in size which we'll further
try to strdup just below too...


I haven't done research on our parsing robustness, but it's not the most
complicated task qemu has. The alternative is to have a fixed size message
on a different virtio port. But again, once we have a kernel alternative
(pstore?) we should switch.



> @@ -163,6 +177,37 @@ static void chr_event(void *opaque, int event)
>      }
>  }
>
> +
> +static void qga_message(JSONMessageParser *parser, GQueue *tokens)
> +{
> +    /* VirtConsole *vcon =3D container_of(parser, VirtConsole, parser); =
*/
> +    QObject *obj;
> +    QDict *msg, *data;
> +    const char *event;
> +
> +    obj =3D json_parser_parse(tokens, NULL);
> +    msg =3D qobject_to_qdict(obj);
> +    if (!msg) {
> +        error_report("JSON parsing failed");
> +        return;
> +    }
> +
> +    event =3D qdict_get_try_str(msg, "event");
> +    data =3D qdict_get_qdict(msg, "data");
> +    if (event && g_str_equal(event, "VMDUMP_INFO") && data) {
> +        dump_info.received =3D true;
> +        if (qdict_haskey(data, "phys-base")) {
> +            dump_info.has_phys_base =3D true;
> +            dump_info.phys_base =3D qdict_get_try_uint(data, "phys-base"=
,
0);
> +        }
> +        if (qdict_haskey(data, "text")) {
> +            dump_info.has_text =3D true;
> +            dump_info.text =3D qdict_get_try_uint(data, "text", 0);
> +        }
> +        dump_info.vmcoreinfo =3D g_strdup(qdict_get_try_str(data,
"vmcoreinfo"));
> +    }
> +}


Regards,
Daniel
--
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/
:|
|: http://libvirt.org              -o-             http://virt-manager.org
:|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/
:|
