Received: from eggs.gnu.org ([209.51.188.92]:47932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gts49-0004Sq-74
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:47:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liam.merwick@oracle.com>) id 1gts47-0001mq-Pa
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:46:56 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50344)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <liam.merwick@oracle.com>)
	id 1gts42-0001fi-AK
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 05:46:53 -0500
References: <1550004500-24485-1-git-send-email-liam.merwick@oracle.com>
	<1550004500-24485-3-git-send-email-liam.merwick@oracle.com>
	<ae83288a-2d71-b67e-938a-99faf9d7f185@linux.ibm.com>
From: Liam Merwick <liam.merwick@oracle.com>
Message-ID: <43ebb975-52ab-b945-5243-da5da933ab81@oracle.com>
Date: Wed, 13 Feb 2019 10:46:35 +0000
MIME-Version: 1.0
In-Reply-To: <ae83288a-2d71-b67e-938a-99faf9d7f185@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 3/3] tpm_tis: convert
 tpm_tis_show_buffer() to use trace event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.ibm.com>, qemu-devel@nongnu.org
Cc: philmd@redhat.com, liam.merwick@oracle.com

On 12/02/2019 21:01, Stefan Berger wrote:
> On 2/12/19 3:48 PM, Liam Merwick wrote:
>> cppcheck reports:
>>
>> [hw/tpm/tpm_tis.c:113]: (warning) %d in format string (no. 2) requires=
=20
>> 'int' but the argument type is 'unsigned int'
>>
>> Rather than just converting the format specifier to use '%u", the
>> tpm_tis_show_buffer() function is converted to use trace points and
>> the two debug callers use the trace event infrastructure so that it's
>> available in production cases also and not just when DEBUG_TIS is=20
>> enabled.
>>
>> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
>> ---
>>
>> Sample trace output
>>
>> % echo tpm_tis_show_buffer > /tmp/events
>> % export=20
>> QTEST_QEMU_BINARY=3D"/home/Development/qemu-upstream/x86_64-softmmu/qe=
mu-system-x86_64=20
>> --trace events=3D/tmp/events"
>> % tests/tpm-tis-test
>> /D=3D/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_localit=
ies:=20
>> OK
>> /D=3D/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_=
reg:=20
>> OK
>> /D=3D/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_=
reg_seize:=20
>> OK
>> /D=3D/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_access_=
reg_release:=20
>> OK
>> /D=3D/home/Development/qemu-upstream/hw/tpm/tpm-tis/test_check_transmi=
t: OK
>> % ./scripts/simpletrace.py trace-events-all trace-30665
>> tpm_tis_show_buffer 0.000 pid=3D30665 string=3Dtpm_tis: To TPM len=3D0=
xc=20
>> line=3D80 01 00 00 00 0C 00 00 01 44 00 00
>> tpm_tis_show_buffer 256.581 pid=3D30665 string=3Dtpm_tis: From TPM len=
=3D0xa=20
>> line=3D80 01 00 00 00 0A 00 00 01 01
>=20
>=20
> should now be 'length=3D10' and then a new line with just the bytes?
>=20

The example I gave was using --enable-trace-backends=3Dsimple (which=20
AFAICT doesn't use the format string, just the name/type of the parameter=
s)

tpm_tis_show_buffer 0.000 pid=3D8416 direction=3DTo TPM len=3D0xc line=3D=
80 01=20
00 00 00 0C 00 00 01 44 00 00
tpm_tis_show_buffer 303.909 pid=3D8416 direction=3DFrom TPM len=3D0xa lin=
e=3D80=20
01 00 00 00 0A 00 00 01 01

Below is the output with --enable-trace-backends=3Dlog which does include=
=20
the newline

1255@1550051983.333949:tpm_tis_show_buffer direction: To TPM len: 12
buf: 80 01 00 00 00 0C 00 00 01 44 00 00
1255@1550051983.334213:tpm_tis_show_buffer direction: From TPM len: 10
buf: 80 01 00 00 00 0A 00 00 01 01

(those include a few tweaks for v4 I made based on investigating this=20
question: dropped "tpm_tis: " since the function name is now printed by=20
the tracing framework, renamed some of the parameters to=20
trace_tpm_tis_show_buffer() and adjusted the format string)


diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
index 18e19d5f900d..d7b9bee85741 100644
--- a/hw/tpm/tpm_tis.c
+++ b/hw/tpm/tpm_tis.c
@@ -155,8 +155,7 @@ static void tpm_tis_sts_set(TPMLocality *l, uint32_t=20
flags)
  static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
  {
      if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                            "tpm_tis: To TPM");
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "To TPM");
      }

      /*
@@ -325,8 +324,7 @@ static void tpm_tis_request_completed(TPMIf *ti, int=20
ret)
      s->rw_offset =3D 0;

      if (trace_event_get_state_backends(TRACE_TPM_TIS_SHOW_BUFFER)) {
-        tpm_tis_show_buffer(s->buffer, s->be_buffer_size,
-                            "tpm_tis: From TPM");
+        tpm_tis_show_buffer(s->buffer, s->be_buffer_size, "From TPM");
      }

      if (TPM_TIS_IS_VALID_LOCTY(s->next_locty)) {
diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
index c0267d075027..f45dcd220993 100644
--- a/hw/tpm/trace-events
+++ b/hw/tpm/trace-events
@@ -36,7 +36,7 @@ tpm_emulator_pre_save(void) ""
  tpm_emulator_inst_init(void) ""

  # hw/tpm/tpm_tis.c
-tpm_tis_show_buffer(const char *string, size_t len, const char *line)=20
"tpm_tis: %s length =3D %zu\n%s"
+tpm_tis_show_buffer(const char *direction, size_t len, const char *buf)=20
"direction: %s len: %zu\nbuf: %s


>=20
>>
>> =C2=A0 hw/tpm/tpm_tis.c=C2=A0=C2=A0=C2=A0 | 25 +++++++++++++++++------=
--
>> =C2=A0 hw/tpm/trace-events |=C2=A0 1 +
>> =C2=A0 2 files changed, 18 insertions(+), 8 deletions(-)
>>
>> diff --git a/hw/tpm/tpm_tis.c b/hw/tpm/tpm_tis.c
>> index 772431f20874..18e19d5f900d 100644
>> --- a/hw/tpm/tpm_tis.c
>> +++ b/hw/tpm/tpm_tis.c
>> @@ -108,17 +108,26 @@ static uint8_t tpm_tis_locality_from_addr(hwaddr=
=20
>> addr)
>> =C2=A0 static void tpm_tis_show_buffer(const unsigned char *buffer,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size_t buffer_size, c=
onst char *string)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 uint32_t len, i;
>> +=C2=A0=C2=A0=C2=A0 size_t len, i;
>> +=C2=A0=C2=A0=C2=A0 char *line_buffer, *p;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D MIN(tpm_cmd_get_size(buffer), b=
uffer_size);
>> -=C2=A0=C2=A0=C2=A0 printf("tpm_tis: %s length =3D %d\n", string, len)=
;
>> -=C2=A0=C2=A0=C2=A0 for (i =3D 0; i < len; i++) {
>> +
>> +=C2=A0=C2=A0=C2=A0 /*
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * allocate enough room for 3 chars per buffe=
r entry plus
>> +=C2=A0=C2=A0=C2=A0=C2=A0 * a newline after every 16 chars.
>=20
>=20
> This is missing the terminating null byte.
>=20


will fix in v4

Regards,
Liam


>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0 */
>> +=C2=A0=C2=A0=C2=A0 line_buffer =3D g_malloc(len * 3 + (len / 16));
>> +
>> +=C2=A0=C2=A0=C2=A0 for (i =3D 0, p =3D line_buffer; i < len; i++) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (i && !(i % =
16)) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pr=
intf("\n");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p =
+=3D sprintf(p, "\n");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("%.2X ", buffer[i])=
;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 p +=3D sprintf(p, "%.2X ",=
 buffer[i]);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0 printf("\n");
>> +=C2=A0=C2=A0=C2=A0 trace_tpm_tis_show_buffer(string, len, line_buffer=
);
>> +
>> +=C2=A0=C2=A0=C2=A0 g_free(line_buffer);
>> =C2=A0 }
>> =C2=A0 /*
>> @@ -145,7 +154,7 @@ static void tpm_tis_sts_set(TPMLocality *l,=20
>> uint32_t flags)
>> =C2=A0=C2=A0 */
>> =C2=A0 static void tpm_tis_tpm_send(TPMState *s, uint8_t locty)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 if (DEBUG_TIS) {
>> +=C2=A0=C2=A0=C2=A0 if (trace_event_get_state_backends(TRACE_TPM_TIS_S=
HOW_BUFFER)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tis_show_bu=
ffer(s->buffer, s->be_buffer_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm_tis: To TPM");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -315,7 +324,7 @@ static void tpm_tis_request_completed(TPMIf *ti,=20
>> int ret)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->loc[locty].state =3D TPM_TIS_STATE_C=
OMPLETION;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->rw_offset =3D 0;
>> -=C2=A0=C2=A0=C2=A0 if (DEBUG_TIS) {
>> +=C2=A0=C2=A0=C2=A0 if (trace_event_get_state_backends(TRACE_TPM_TIS_S=
HOW_BUFFER)) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tpm_tis_show_bu=
ffer(s->buffer, s->be_buffer_size,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 "tpm_tis: From TPM");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> diff --git a/hw/tpm/trace-events b/hw/tpm/trace-events
>> index 920d32ad5514..c0267d075027 100644
>> --- a/hw/tpm/trace-events
>> +++ b/hw/tpm/trace-events
>> @@ -36,6 +36,7 @@ tpm_emulator_pre_save(void) ""
>> =C2=A0 tpm_emulator_inst_init(void) ""
>> =C2=A0 # hw/tpm/tpm_tis.c
>> +tpm_tis_show_buffer(const char *string, size_t len, const char *line)=
=20
>> "tpm_tis: %s length =3D %zu\n%s"
>> =C2=A0 tpm_tis_raise_irq(uint32_t irqmask) "Raising IRQ for flag 0x%08=
x"
>> =C2=A0 tpm_tis_new_active_locality(uint8_t locty) "Active locality is =
now %d"
>> =C2=A0 tpm_tis_abort(uint8_t locty) "New active locality is %d"
>=20
>=20
