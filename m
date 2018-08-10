Received: from eggs.gnu.org ([2001:4830:134:3::10]:54031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo1KX-00051o-Ad
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:55:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fo1KV-0001JM-SB
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 02:55:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20180809114417.28718-1-marcandre.lureau@redhat.com>
	<20180809114417.28718-4-marcandre.lureau@redhat.com>
	<CAJ+F1C+dpfLNb4C-5LxEPbRBR7C0HVSce7by4ckppyNiFZcsRQ@mail.gmail.com>
Date: Fri, 10 Aug 2018 08:55:13 +0200
In-Reply-To: <CAJ+F1C+dpfLNb4C-5LxEPbRBR7C0HVSce7by4ckppyNiFZcsRQ@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Thu, 9 Aug 2018
	16:38:47 +0200")
Message-ID: <87in4iu2we.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/4] monitor: fix oob command leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: QEMU <qemu-devel@nongnu.org>, Hannes Reinecke <hare@suse.com>, Fam Zheng <famz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Thu, Aug 9, 2018 at 1:44 PM, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@redhat.com> wrote:
>> Spotted by ASAN, during make check...
>>
>> Direct leak of 40 byte(s) in 1 object(s) allocated from:
>>     #0 0x7f8e27262c48 in malloc (/lib64/libasan.so.5+0xeec48)
>>     #1 0x7f8e26a5f3c5 in g_malloc (/lib64/libglib-2.0.so.0+0x523c5)
>>     #2 0x555ab67078a8 in qstring_from_str /home/elmarco/src/qq/qobject/q=
string.c:67
>>     #3 0x555ab67071e4 in qstring_new /home/elmarco/src/qq/qobject/qstrin=
g.c:24
>>     #4 0x555ab6713fbf in qstring_from_escaped_str /home/elmarco/src/qq/q=
object/json-parser.c:144
>>     #5 0x555ab671738c in parse_literal /home/elmarco/src/qq/qobject/json=
-parser.c:506
>>     #6 0x555ab67179c3 in parse_value /home/elmarco/src/qq/qobject/json-p=
arser.c:569
>>     #7 0x555ab6715123 in parse_pair /home/elmarco/src/qq/qobject/json-pa=
rser.c:306
>>     #8 0x555ab6715483 in parse_object /home/elmarco/src/qq/qobject/json-=
parser.c:357
>>     #9 0x555ab671798b in parse_value /home/elmarco/src/qq/qobject/json-p=
arser.c:561
>>     #10 0x555ab6717a6b in json_parser_parse_err /home/elmarco/src/qq/qob=
ject/json-parser.c:592
>>     #11 0x555ab4fd4dcf in handle_qmp_command /home/elmarco/src/qq/monito=
r.c:4257
>>     #12 0x555ab6712c4d in json_message_process_token /home/elmarco/src/q=
q/qobject/json-streamer.c:105
>>     #13 0x555ab67e01e2 in json_lexer_feed_char /home/elmarco/src/qq/qobj=
ect/json-lexer.c:323
>>     #14 0x555ab67e0af6 in json_lexer_feed /home/elmarco/src/qq/qobject/j=
son-lexer.c:373
>>     #15 0x555ab6713010 in json_message_parser_feed /home/elmarco/src/qq/=
qobject/json-streamer.c:124
>>     #16 0x555ab4fd58ec in monitor_qmp_read /home/elmarco/src/qq/monitor.=
c:4337
>>     #17 0x555ab6559df2 in qemu_chr_be_write_impl /home/elmarco/src/qq/ch=
ardev/char.c:175
>>     #18 0x555ab6559e95 in qemu_chr_be_write /home/elmarco/src/qq/chardev=
/char.c:187
>>     #19 0x555ab6560127 in fd_chr_read /home/elmarco/src/qq/chardev/char-=
fd.c:66
>>     #20 0x555ab65d9c73 in qio_channel_fd_source_dispatch /home/elmarco/s=
rc/qq/io/channel-watch.c:84
>>     #21 0x7f8e26a598ac in g_main_context_dispatch (/lib64/libglib-2.0.so=
.0+0x4c8ac)
>>
>> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> It looks like it was introduced with commit
> b27314567d4cd8e204a18feba60d3341fb2d1aed "qmp: Simplify code around
> monitor_qmp_dispatch_one()"

Yes.

Before that commit, handle_qmp_command() freed @req and @id as follows.

* Early errors: goto err, where we free req, and leak @id (I think).

* Out of band: store @req and @id in @req_obj, free it in
  monitor_qmp_dispatch_one().

* In band: store @req and @id in @req_obj

  - queue full: free by calling qmp_request_free()

  - else: enqueue, monitor_qmp_bh_dispatcher() will deqeueue and pass to
    monitor_qmp_dispatch_one(), which frees.

Current head always stores @req and @id in @req_obj.  It frees as
follows.

* Out of band: it doesn't, since monitor_qmp_dispatch(), renamed from
  monitor_qmp_dispatch_one(), doesn't free anymore.  This patch fixes
  it.

* In band:

  - queue full: free by calling qmp_request_free().

  - else: enqueue, monitor_qmp_bh_dispatcher() will deqeueue and pass to
    monitor_qmp_dispatch(), then free with qmp_request_free().

Looks like the commit replaced one leak by another one.

>
>> ---
>>  monitor.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/monitor.c b/monitor.c
>> index 77861e96af..a1999e396c 100644
>> --- a/monitor.c
>> +++ b/monitor.c
>> @@ -4277,6 +4277,8 @@ static void handle_qmp_command(JSONMessageParser *=
parser, GQueue *tokens)
>>          trace_monitor_qmp_cmd_out_of_band(qobject_get_try_str(id)
>>                                            ?: "");
>>          monitor_qmp_dispatch(mon, req, id);
>> +        qobject_unref(req);
>> +        qobject_unref(id);
>>          return;
>>      }
>>
>> --
>> 2.18.0.547.g1d89318c48
>>
>>

I'm not going to argue for inclusion in 3.0, because OOB is experimental
and off by default due to its remaining flaws.

Cc: qemu-stable@nongnu.org
Reviewed-by: Markus Armbruster <armbru@redhat.com>
