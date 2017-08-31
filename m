Received: from eggs.gnu.org ([2001:4830:134:3::10]:48841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dnSBZ-00050T-HS
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:19:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1dnSBV-0008Ge-P0
	for qemu-devel@nongnu.org; Thu, 31 Aug 2017 12:19:17 -0400
References: <20170829204934.9039-1-jsnow@redhat.com>
	<20170829204934.9039-6-jsnow@redhat.com>
	<cb291f47-2fb5-8d97-ff89-c8ccaded345c@amsat.org>
	<4564eeb6-dfcb-0cb0-bf4f-3bce117314ee@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <8deb650a-3176-4a32-4814-b819f04325f9@redhat.com>
Date: Thu, 31 Aug 2017 18:19:01 +0200
MIME-Version: 1.0
In-Reply-To: <4564eeb6-dfcb-0cb0-bf4f-3bce117314ee@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/9] IDE: replace DEBUG_AIO with trace
 events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>

On 08/31/17 01:25, John Snow wrote:
> CCing Laszlo Ersek literally just for laughs, as he is the most
> entertaining language lawyer I know of.
>=20
> Laszlo, please feel free to ignore this if you don't care :P
>=20
> On 08/29/2017 11:14 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>> Hi John,
>>
>> On 08/29/2017 05:49 PM, John Snow wrote:
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>   hw/ide/atapi.c            |  5 +----
>>>   hw/ide/core.c             | 17 ++++++++++-------
>>>   hw/ide/trace-events       |  3 +++
>>>   include/hw/ide/internal.h |  6 ++++--
>>>   4 files changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/hw/ide/atapi.c b/hw/ide/atapi.c
>>> index 37fa699..b8fc51e 100644
>>> --- a/hw/ide/atapi.c
>>> +++ b/hw/ide/atapi.c
>>> @@ -416,10 +416,7 @@ static void ide_atapi_cmd_read_dma_cb(void
>>> *opaque, int ret)
>>>           s->io_buffer_size =3D n * 2048;
>>>           data_offset =3D 0;
>>>       }
>>> -#ifdef DEBUG_AIO
>>> -    printf("aio_read_cd: lba=3D%u n=3D%d\n", s->lba, n);
>>> -#endif
>>> -
>>> +    trace_ide_atapi_cmd_read_dma_cb_aio(s, s->lba, n);
>>>       s->bus->dma->iov.iov_base =3D (void *)(s->io_buffer + data_offs=
et);
>>>       s->bus->dma->iov.iov_len =3D n * ATAPI_SECTOR_SIZE;
>>>       qemu_iovec_init_external(&s->bus->dma->qiov, &s->bus->dma->iov,=
 1);
>>> diff --git a/hw/ide/core.c b/hw/ide/core.c
>>> index 82a19b1..a1c90e9 100644
>>> --- a/hw/ide/core.c
>>> +++ b/hw/ide/core.c
>>> @@ -58,6 +58,13 @@ static const int smart_attributes[][12] =3D {
>>>       { 190,  0x03, 0x00, 0x45, 0x45, 0x1f, 0x00, 0x1f, 0x1f, 0x00,
>>> 0x00, 0x32},
>>>   };
>>>   +const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT] =3D {
>>> +    [IDE_DMA_READ] =3D "DMA READ",
>>> +    [IDE_DMA_WRITE] =3D "DMA WRITE",
>>> +    [IDE_DMA_TRIM] =3D "DMA TRIM",
>>> +    [IDE_DMA_ATAPI] =3D "DMA ATAPI"
>>> +};
>>> +
>>>   static void ide_dummy_transfer_stop(IDEState *s);
>>>     static void padstr(char *str, const char *src, int len)
>>> @@ -860,10 +867,8 @@ static void ide_dma_cb(void *opaque, int ret)
>>>           goto eot;
>>>       }
>>>   -#ifdef DEBUG_AIO
>>> -    printf("ide_dma_cb: sector_num=3D%" PRId64 " n=3D%d, cmd_cmd=3D%=
d\n",
>>> -           sector_num, n, s->dma_cmd);
>>> -#endif
>>> +    trace_ide_dma_cb(s, sector_num, n,
>>> +                     IDE_DMA_CMD_lookup[s->dma_cmd]);
>>>         if ((s->dma_cmd =3D=3D IDE_DMA_READ || s->dma_cmd =3D=3D
>>> IDE_DMA_WRITE) &&
>>>           !ide_sect_range_ok(s, sector_num, n)) {
>>> @@ -2391,9 +2396,7 @@ void ide_bus_reset(IDEBus *bus)
>>>         /* pending async DMA */
>>>       if (bus->dma->aiocb) {
>>> -#ifdef DEBUG_AIO
>>> -        printf("aio_cancel\n");
>>> -#endif
>>> +        trace_ide_bus_reset_aio();
>>>           blk_aio_cancel(bus->dma->aiocb);
>>>           bus->dma->aiocb =3D NULL;
>>>       }
>>> diff --git a/hw/ide/trace-events b/hw/ide/trace-events
>>> index 8c79a6c..cc8949c 100644
>>> --- a/hw/ide/trace-events
>>> +++ b/hw/ide/trace-events
>>> @@ -18,6 +18,8 @@ ide_cancel_dma_sync_remaining(void) "draining all
>>> remaining requests"
>>>   ide_sector_read(int64_t sector_num, int nsectors) "sector=3D%"PRId6=
4"
>>> nsectors=3D%d"
>>>   ide_sector_write(int64_t sector_num, int nsectors) "sector=3D%"PRId=
64"
>>> nsectors=3D%d"
>>>   ide_reset(void *s) "IDEstate %p"
>>> +ide_bus_reset_aio(void) "aio_cancel"
>>> +ide_dma_cb(void *s, int64_t sector_num, int n, const char *dma)
>>> "IDEState %p; sector_num=3D%"PRId64" n=3D%d cmd=3D%s"
>>>     # BMDMA HBAs:
>>>   @@ -51,5 +53,6 @@ ide_atapi_cmd_reply_end_new(void *s, int status)
>>> "IDEState: %p; new transfer sta
>>>   ide_atapi_cmd_check_status(void *s) "IDEState: %p"
>>>   ide_atapi_cmd_read(void *s, const char *method, int lba, int
>>> nb_sectors) "IDEState: %p; read %s: LBA=3D%d nb_sectors=3D%d"
>>>   ide_atapi_cmd(void *s, uint8_t cmd) "IDEState: %p; cmd: 0x%02x"
>>> +ide_atapi_cmd_read_dma_cb_aio(void *s, int lba, int n) "IDEState: %p=
;
>>> aio read: lba=3D%d n=3D%d"
>>>   # Warning: Verbose
>>>   ide_atapi_cmd_packet(void *s, uint16_t limit, const char *packet)
>>> "IDEState: %p; limit=3D0x%x packet: %s"
>>> diff --git a/include/hw/ide/internal.h b/include/hw/ide/internal.h
>>> index 74efe8a..db9fde0 100644
>>> --- a/include/hw/ide/internal.h
>>> +++ b/include/hw/ide/internal.h
>>> @@ -14,7 +14,6 @@
>>>   #include "block/scsi.h"
>>>     /* debug IDE devices */
>>> -//#define DEBUG_AIO
>>>   #define USE_DMA_CDROM
>>>     typedef struct IDEBus IDEBus;
>>> @@ -333,12 +332,15 @@ struct unreported_events {
>>>   };
>>>     enum ide_dma_cmd {
>>> -    IDE_DMA_READ,
>>> +    IDE_DMA_READ =3D 0,
>>>       IDE_DMA_WRITE,
>>>       IDE_DMA_TRIM,
>>>       IDE_DMA_ATAPI,
>>> +    IDE_DMA__COUNT
>>>   };
>>>   +extern const char *IDE_DMA_CMD_lookup[IDE_DMA__COUNT];
>>
>> I recommend you to avoid this declaring extern const array with size, =
I
>> remember some compilers (old GCC?) ignoring array size in extern. Eric
>> will correct me!
>>
>> It is much safer to use a getter:
>>
>=20
> Well, whether or not the compiler ignores it, you're right that it's
> safer to use a getter. I don't think the width being declared HURTS any
> compiler though, does it?

If, in the above declaration, you say

extern const char *IDE_DMA_CMD_lookup[];

then the "IDE_DMA_CMD_lookup" will have "incomplete array type". In a
translation unit that includes this declaration, but doesn't actually
*define* the array (thereby completing its type), you can e.g. subscript
the array like this:

  IDE_CMD_DMA_lookup[IDE_DMA_WRITE]

but you cannot do anything with it that would require it to have a
complete type, such as:

  sizeof IDE_CMD_DMA_lookup


If you declare the array as quoted above, then the type will be complete
for all translation units that include the declaration, not just for the
one that defines the array.

Which one I'd recommend depends on the use case. If it's OK to expose
the size of the array to all consumers (or the IDE_DMA__COUNT
enumeration constant), then I'd go with the complete type in the
declaration. It communicates the intent.

And no, the compiler is not required to catch your out-of-bounds access
in either case; but that's not the point. The point is that the human
that looks at the declaration will know how to bounds-check the access.

If you write a getter function, then either declaration will work just
fine, but in that case, you don't even need the array. Just add a switch
statement to your getter, and return the addresses of open-coded string
literals.

>=20
>> const char *IDE_DMA_CMD_lookup(enum ide_dma_cmd cmd)
>> {
>>     static const char *IDE_DMA_CMD_name[IDE_DMA__COUNT] =3D {
>>         [IDE_DMA_READ] =3D "DMA READ",
>>         [IDE_DMA_WRITE] =3D "DMA WRITE",
>>         [IDE_DMA_TRIM] =3D "DMA TRIM",
>>         [IDE_DMA_ATAPI] =3D "DMA ATAPI"
>>     };
>>
>>     return IDE_DMA_CMD_name[cmd];
>> };
>>
>=20
> Why is this safer...?
>=20
> Here's my opinion of enums:
>=20
> jhuston@probe ~/s/scratch> cat enum.c
> enum foo {
>     FOO_A =3D 0,
>     FOO_B
> };
>=20
> int fn(enum foo in)
> {
>     switch (in) {
>     case FOO_A:
>     case FOO_B:
>         return 0;
>     default:
>         return 1;
>     }
> }
>=20
> int main(int argc, char *argv[])
> {
>     return fn(2);
> }
>=20
>=20
> jhuston@probe ~/s/scratch> gcc -ansi -Wall -pedantic -o enum enum.c
> jhuston@probe ~/s/scratch> ./enum
> jhuston@probe ~/s/scratch> echo $status
> 1
>=20
>=20
> No warnings, no messages, it just happily takes a value outside the
> domain and in this case it doesn't explode because I caught it, but,
> take a look:
>=20
> jhuston@probe ~/s/scratch> cat enum.c
> #include <stdio.h>
>=20
> enum foo {
>     FOO_A =3D 0,
>     FOO_B,
>     FOO__COUNT
> };
>=20
> const char *table[FOO__COUNT] =3D {"FOO_A", "FOO_B"};
>=20
> int fn(enum foo in)
> {
>     fprintf(stderr, "%s\n", table[in]);
>     switch (in) {
>     case FOO_A:
>     case FOO_B:
>         return 0;
>     default:
>         return 1;
>     }
> }
>=20
> int main(int argc, char *argv[])
> {
>     return fn(2);
> }
>=20
> Similar program, let's compile it:
>=20
> jhuston@probe ~/s/scratch> gcc -ansi -Wall -pedantic -o enum enum.c
> jhuston@probe ~/s/scratch> ./enum
> =EF=BF=BD =EF=BF=BD
>=20
>=20
> Ah, dang.
>=20
> This is why I prefer to have my assertions and don't trust enums to be
> checked rigorously.
>=20
> For anyone playing along at home, yes, if you specify at least -O1 here
> it will catch it:
>=20
> jhuston@probe ~/s/scratch> gcc -ansi -Wall -pedantic -O3 -o enum enum.c
> enum.c: In function =E2=80=98main=E2=80=99:
> enum.c:13:5: warning: array subscript is above array bounds [-Warray-bo=
unds]
>      fprintf(stderr, "%s\n", table[in]);
>      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Oh no, what the hell is clang up to, though?
>=20
> jhuston@probe ~/s/scratch> clang -ansi -Wall -pedantic -O3 -o enum enum=
.c
> jhuston@probe ~/s/scratch>
>=20
>=20
> Oh no...
>=20
> http://i.imgur.com/uRvorq3.jpg

I wouldn't like to quote all the standardese related to enums. My point
here is that the compiler might choose "signed char", for example, for
representing the "enum foo" type. Let's say the range of "signed char"
is -128..127 inclusive.

Now assume you pass value 128 (of type "int") to a function that takes
"enum foo", such as your fn(). The argument is converted as in an
assignment, and the following applies:

  6.3 Conversions
  6.3.1 Arithmetic operands
  6.3.1.1 Boolean, characters, and integers
    1 [...]
       - The rank of any enumerated type shall equal the rank of the
         compatible integer type (see 6.7.2.2).
    [...]
  6.3.1.3 Signed and unsigned integers
    [...]
    3 Otherwise, the new type is signed and the value cannot be
      represented in it; either the result is implementation-defined or
      an implementation-defined signal is raised.

Dependent on what the docs for your C language implementation say, you
could get total garbage in fn(), or you could get a signal before your
code in fn() is reached.

IOW, if you cannot guarantee *before* the function call that the value
you pass to fn() -- or convert to "enum foo" otherwise -- will nicely
fit in "enum foo"'s represenative integer type, then catching it in fn()
is too late.

I suggest assigning to "enum foo" only
- another "enum foo" object,
- a matching enumeration constant (which has type "int", but will fit of
  course),
- any integer value that has been range-checked explicitly.

The last point does encourage that your getter function should take,
say, "unsigned int" rather than "enum foo"; it handles incorrect calls
more portably.

... I'm unsure if this wall of text is relevant *at all* here, but I've
had to live up to past entertainment! ;)

Laszlo

>=20
>> If you agree:
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>>
>=20
> Somewhat. I will write a getter that does bounds checking. It _is_ safe=
r
> that way, though I don't think we'll ever run into a situation where it
> would come up.
>=20
>>> +
>>>   #define ide_cmd_is_read(s) \
>>>       ((s)->dma_cmd =3D=3D IDE_DMA_READ)
>>> =20
>>
>=20
