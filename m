Received: from eggs.gnu.org ([2001:4830:134:3::10]:35330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxspy-0002jI-Bq
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:15:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cxspv-0005TY-8Y
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:15:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cxspv-0005T1-2U
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 06:15:47 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <CA+KKJYCOKxea1TJY0Uu8HSzYLoh3G=EX-DeKbM+r40HhoxfJrw@mail.gmail.com>
	<20170403151953.GE3539@stefanha-x1.localdomain>
Date: Tue, 11 Apr 2017 12:15:44 +0200
In-Reply-To: <20170403151953.GE3539@stefanha-x1.localdomain> (Stefan
	Hajnoczi's message of "Mon, 3 Apr 2017 16:19:53 +0100")
Message-ID: <87o9w3b67j.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] debug: made printf always compile in debug
 output
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Danil Antonov <g.danil.anto@gmail.com>, qemu-devel@nongnu.org

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, Mar 27, 2017 at 02:50:47PM +0300, Danil Antonov wrote:
>> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
>> index 2b0f3e1..bf880c1 100644
>> --- a/hw/acpi/pcihp.c
>> +++ b/hw/acpi/pcihp.c
>> @@ -39,13 +39,16 @@
>>  #include "qom/qom-qobject.h"
>>  #include "qapi/qmp/qint.h"
>> 
>> -//#define DEBUG
>> 
>> -#ifdef DEBUG
>> -# define ACPI_PCIHP_DPRINTF(format, ...)     printf(format, ## __VA_ARGS__)
>> -#else
>> -# define ACPI_PCIHP_DPRINTF(format, ...)     do { } while (0)
>> -#endif
>> +#ifndef DEBUG
>> +#define DEBUG 0
>> +#endif
>> +
>> +#define ACPI_PCIHP_DPRINTF(fmt, ...) do {     \
>> +    if (DEBUG) {                              \
>> +        fprintf(stderr, fmt, ## __VA_ARGS__); \
>> +    }                                         \
>> +} while (0);
>
> The semicolon isn't necessary.  The caller provides it.

s/isn't necessary/is wrong/

>   ACPI_PCIHP_DPRINTF("foo\n");

Your defintion of ACPI_PCIHP_DPRINTF() expands this into *two*
statements, the one you want, plus a null statement:

    do { ... } while (0);;
    \___________________/|
      first statment     |
                     null statement

Breaks in places where C expects a statement, e.g.

    if (cond1)
        if (cond2)
            ACPI_PCIHP_DPRINTF(...);
        else
            bar();

Gets parsed like

    if (cond1) {
        if (cond2) {
            first statement
        }
    }
    null statement
    else // compiler chokes, fortunately
        bar();

> It's normal to define statement-like macros with do { ... } while (0)
> and no semicolon in the definition.

A macro should expand into exactly one expression or exactly one
statement.  Intentional deviations from this rule may be okay.
Accidental deviations aren't.
