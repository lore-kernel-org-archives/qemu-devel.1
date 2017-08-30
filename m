Received: from eggs.gnu.org ([2001:4830:134:3::10]:34247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBol-0002Yo-Vr
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:50:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dnBok-0001UI-FU
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 18:50:39 -0400
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-9-jsnow@redhat.com>
	<20170830091757.GD24565@stefanha-x1.localdomain>
From: John Snow <jsnow@redhat.com>
Message-ID: <cc0cf2e3-4811-c8f8-979c-9a82041766a8@redhat.com>
Date: Wed, 30 Aug 2017 18:50:27 -0400
MIME-Version: 1.0
In-Reply-To: <20170830091757.GD24565@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 8/9] AHCI: pretty-print FIS
 to buffer instead of stderr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, f4bug@amsat.org



On 08/30/2017 05:17 AM, Stefan Hajnoczi wrote:
> On Tue, Aug 29, 2017 at 04:49:33PM -0400, John Snow wrote:
>> The current FIS printing routines dump the FIS to screen. adjust this
>> such that it dumps to buffer instead, then use this ability to have
>> FIS dump mechanisms via trace-events instead of compiled defines.
>>
>> Signed-off-by: John Snow <jsnow@redhat.com>
>> ---
>>  hw/ide/ahci.c       | 54 +++++++++++++++++++++++++++++++++++++++++++-=
---------
>>  hw/ide/trace-events |  4 ++++
>>  2 files changed, 48 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
>> index a0a4dd6..2e75f9b 100644
>> --- a/hw/ide/ahci.c
>> +++ b/hw/ide/ahci.c
>> @@ -644,20 +644,45 @@ static void ahci_reset_port(AHCIState *s, int po=
rt)
>>      ahci_init_d2h(d);
>>  }
>> =20
>> -static void debug_print_fis(uint8_t *fis, int cmd_len)
>> +/* Buffer pretty output based on a raw FIS structure. */
>> +static void ahci_pretty_buffer_fis(uint8_t *fis, int cmd_len, char **=
out)
>=20
> Simplified function using GString:
>=20
>   static char *ahci_pretty_buffer_fis(const uint8_t *fis, int cmd_len)
>   {
>       GString *s =3D g_string_new("FIS:");
>       int i;
>=20
>       for (i =3D 0; i < cmd_len; i++) {
>           if (i % 16 =3D=3D 0) {
>               g_string_append_printf(s, "\n0x%02x:", i);
> 	  }
>=20
>           g_string_append_printf(s, " %02x", fis[i]);
>       }
>=20
>       g_string_append_c('\n');
>       return g_string_free(s, FALSE);
>   }
>=20
> It's less efficient due to extra mallocs but a lot easier to read.
>=20

eeeyyyyeahhhh I guess I don't need to be bleedingly efficient with debug
printfs...

And in this example I don't need to worry about the math being precisely
correct. I'll make the change :(

>>  {
>> -#if DEBUG_AHCI
>> +    size_t bufsize;
>> +    char *pbuf;
>> +    char *pptr;
>> +    size_t lines =3D DIV_ROUND_UP(cmd_len, 16);
>> +    const char *preamble =3D "FIS:";
>>      int i;
>> =20
>> -    fprintf(stderr, "fis:");
>> +    /* Total amount of memory to store FISes in HBA memory */
>> +    g_assert_cmpint(cmd_len, <=3D, 0x100);
>> +    g_assert(out);
>> +
>> +    /* Printed like:
>> +     * FIS:\n
>> +     * 0x00: 00 11 22 33 44 55 66 77 88 99 aa bb cc dd ee \n
>> +     * 0x10: ff \n
>> +     * \0
>> +     *
>> +     * Four bytes for the preamble, seven for each line prefix (inclu=
ding a
>> +     * newline to start a new line), three bytes for each source byte=
,
>> +     * a trailing newline and a terminal null byte.
>> +     */
>> +
>> +    bufsize =3D strlen(preamble) + ((6 + 1) * lines) + (3 * cmd_len) =
+ 1 + 1;
>> +    pbuf =3D g_malloc(bufsize);
>> +    pptr =3D pbuf;
>> +    pptr +=3D sprintf(pptr, "%s", preamble);
>>      for (i =3D 0; i < cmd_len; i++) {
>>          if ((i & 0xf) =3D=3D 0) {
>> -            fprintf(stderr, "\n%02x:",i);
>> +            pptr +=3D sprintf(pptr, "\n0x%02x: ", i);
>>          }
>> -        fprintf(stderr, "%02x ",fis[i]);
>> +        pptr +=3D sprintf(pptr, "%02x ", fis[i]);
>>      }
>> -    fprintf(stderr, "\n");
>> -#endif
>> +    pptr +=3D sprintf(pptr, "\n");
>> +    pptr +=3D 1; /* \0 */
>> +    g_assert(pbuf + bufsize =3D=3D pptr);
>> +    *out =3D pbuf;
>>  }
>> =20
>>  static bool ahci_map_fis_address(AHCIDevice *ad)
>> @@ -1201,7 +1226,12 @@ static void handle_reg_h2d_fis(AHCIState *s, in=
t port,
>>       * table to ide_state->io_buffer */
>>      if (opts & AHCI_CMD_ATAPI) {
>>          memcpy(ide_state->io_buffer, &cmd_fis[AHCI_COMMAND_TABLE_ACMD=
], 0x10);
>> -        debug_print_fis(ide_state->io_buffer, 0x10);
>> +        if (TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED) {
>=20
> This should probably be:
>=20
>   if (trace_event_get_state_backends(TRACE_HANDLE_REG_H2D_FIS_DUMP)) {
>=20
> The difference is that TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED is set at
> compile time while trace_event_get_state_backends() checks if the event
> is enabled at run-time.
>=20
> Therefore TRACE_HANDLE_REG_H2D_FIS_DUMP_ENABLED causes the trace event
> to fire even when the user hasn't enabled the trace event yet.  That
> would be a waste of CPU.
>=20

Oh, cool! Nice tip!

>> +            char *pretty_fis;
>> +            ahci_pretty_buffer_fis(ide_state->io_buffer, 0x10, &prett=
y_fis);
>> +            trace_handle_reg_h2d_fis_dump(s, port, pretty_fis);
>> +            g_free(pretty_fis);
>> +        }
>>          s->dev[port].done_atapi_packet =3D false;
>>          /* XXX send PIO setup FIS */
>>      }
>> @@ -1256,8 +1286,12 @@ static int handle_cmd(AHCIState *s, int port, u=
int8_t slot)
>>          trace_handle_cmd_badmap(s, port, cmd_len);
>>          goto out;
>>      }
>> -    debug_print_fis(cmd_fis, 0x80);
>> -
>> +    if (TRACE_HANDLE_CMD_FIS_DUMP_ENABLED) {
>=20
> Same here.
>=20

Sure thing. There's probably a block in ATAPI that needs this treatment,
too.

>> +        char *pretty_fis;
>> +        ahci_pretty_buffer_fis(cmd_fis, 0x80, &pretty_fis);
>> +        trace_handle_cmd_fis_dump(s, port, pretty_fis);
>> +        g_free(pretty_fis);
>> +    }
>>      switch (cmd_fis[0]) {
>>          case SATA_FIS_TYPE_REGISTER_H2D:
>>              handle_reg_h2d_fis(s, port, slot, cmd_fis);
>> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
>> index e15fd77..77ed3c1 100644
>> --- a/hw/ide/trace-events
>> +++ b/hw/ide/trace-events
>> @@ -105,3 +105,7 @@ ahci_cmd_done(void *s, int port) "ahci(%p)[%d]: cm=
d done"
>>  ahci_reset(void *s) "ahci(%p): HBA reset"
>>  allwinner_ahci_mem_read(void *s, void *a, uint64_t addr, uint64_t val=
, unsigned size) "ahci(%p): read a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0x%=
"PRIx64", size=3D%d"
>>  allwinner_ahci_mem_write(void *s, void *a, uint64_t addr, uint64_t va=
l, unsigned size) "ahci(%p): write a=3D%p addr=3D0x%"HWADDR_PRIx" val=3D0=
x%"PRIx64", size=3D%d"
>> +
>> +# Warning: Verbose
>> +handle_reg_h2d_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: =
%s"
>=20
> const char *fis
>=20
>> +handle_cmd_fis_dump(void *s, int port, char *fis) "ahci(%p)[%d]: %s"
>=20
> const char *fis
>=20

Thanks for the =F0=9F=91=80
