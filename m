Received: from eggs.gnu.org ([2001:4830:134:3::10]:39434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMBOV-0003a2-TU
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:28:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMBOR-0005VN-1i
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:28:11 -0500
Received: from mail.ispras.ru ([83.149.199.45]:60822)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mikhail.abakumov@ispras.ru>) id 1eMBOQ-0005Te-Q7
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 06:28:06 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Date: Tue, 05 Dec 2017 14:28:02 +0300
From: Mihail Abakumov <mikhail.abakumov@ispras.ru>
In-Reply-To: <CABdb737B1Ldxr0KPtnrLAJpLgC9=BgE-qQ8a3BeL7DM=ydR9ow@mail.gmail.com>
References: <151127322955.6888.16198535123422076171.stgit@Misha-PC.lan02.inno>
	<151127349122.6888.9523124333246477608.stgit@Misha-PC.lan02.inno>
	<CABdb737B1Ldxr0KPtnrLAJpLgC9=BgE-qQ8a3BeL7DM=ydR9ow@mail.gmail.com>
Message-ID: <0f244258e4250ad6e1e8c096c1fca65f@ispras.ru>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 45/45] windbg: implemented
 kd_api_get_context_ex and kd_api_set_context_ex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, sw@weilnetz.de, Pavel Dovgalyuk <dovgaluk@ispras.ru>, Roman Kagan <rkagan@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

Ladi Prosek =D0=BF=D0=B8=D1=81=D0=B0=D0=BB 2017-11-28 15:44:
> On Tue, Nov 21, 2017 at 3:11 PM, Mihail Abakumov
> <mikhail.abakumov@ispras.ru> wrote:
> [...]
>> diff --git a/windbgstub.c b/windbgstub.c
>> index 36372c0ea5..3bcf6a8cbb 100755
>> --- a/windbgstub.c
>> +++ b/windbgstub.c
>> @@ -224,6 +224,14 @@ static void=20
>> windbg_process_manipulate_packet(ParsingContext *ctx)
>>          kd_api_query_memory(cpu, &ctx->data);
>>          break;
>>=20
>> +    case DbgKdGetContextExApi:
>> +        kd_api_get_context_ex(cpu, &ctx->data);
>> +        break;
>> +
>> +    case DbgKdSetContextExApi:
>> +        kd_api_set_context_ex(cpu, &ctx->data);
>> +        break;
>> +
>>      default:
>>          kd_api_unsupported(cpu, &ctx->data);
>>          break;
>> @@ -262,12 +270,12 @@ static void=20
>> windbg_process_control_packet(ParsingContext *ctx)
>>=20
>>      case PACKET_TYPE_KD_RESET:
>>      {
>> -        SizedBuf buf =3D kd_gen_load_symbols_sc(qemu_get_cpu(0));
>> +        windbg_send_control_packet(ctx->packet.PacketType);
>> +        windbg_state->ctrl_packet_id =3D INITIAL_PACKET_ID;
>=20
> You didn't mention it in the cover email so I'd like to be sure. This
> is what fixed the initial handshake so it works without -b now, is
> that correct? Thanks!
>=20
Yes. It seems for me more logical to send a response first, then a state=20
packet.
Apparently, before that I made a typo. Now Windbg connects immediately,=20
and
for stopping it is necessary to press ctrl+break. But now the option=20
'-b' does
not work in the old version.

>> +        SizedBuf buf =3D kd_gen_load_symbols_sc(qemu_get_cpu(0));
>>          windbg_send_data_packet(buf.data, buf.size,
>>                                  PACKET_TYPE_KD_STATE_CHANGE64);
>> -        windbg_send_control_packet(ctx->packet.PacketType);
>> -        windbg_state->ctrl_packet_id =3D INITIAL_PACKET_ID;
>>          SBUF_FREE(buf);
>>          break;
>>      }
>>=20
