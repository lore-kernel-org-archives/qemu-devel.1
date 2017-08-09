Received: from eggs.gnu.org ([2001:4830:134:3::10]:54074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfRhv-0001Hs-RF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:11:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dfRhq-0001Fw-7g
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:11:35 -0400
Received: from mail-wm0-x232.google.com ([2a00:1450:400c:c09::232]:34529)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dfRhq-0001FC-1t
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 10:11:30 -0400
Received: by mail-wm0-x232.google.com with SMTP id t138so14169809wmt.1
	for <qemu-devel@nongnu.org>; Wed, 09 Aug 2017 07:11:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d9c93599-1d2c-333e-dae0-7da8cc87b133@amsat.org>
References: <CAJSP0QVrCm6TfgU0dsXbudaW3gmGo0YQTTWbNypx6st6mKcSKA@mail.gmail.com>
	<d9c93599-1d2c-333e-dae0-7da8cc87b133@amsat.org>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Wed, 9 Aug 2017 15:11:28 +0100
Message-ID: <CAJSP0QVFHN3U7xxUS1iUY6Ap80tHs2t_wgT26+V86vA8=4BCWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Making QEMU build with Python 3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Ross Burton <ross@burtonini.com>

On Wed, Aug 9, 2017 at 1:53 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> On 08/09/2017 07:16 AM, Stefan Hajnoczi wrote:
> [...]> Python scripts needed to build QEMU are the highest priority.  The=
y
>>
>> are invoked by ./configure or make.  I've identified the following:
>>
>> scripts/signrom.py
>> scripts/qapi*.py
>> scripts/modules/module_block.py
>> scripts/tracetool*
>>
> [...]
>>
>> The fundamentals of adding Python 3 support are:
>>
>> 1. The script must work correctly under both Python 2.6+ and Python 3.
>
> [...]
>>
>> 3. Avoid third-party package dependencies - QEMU currently has none!
>
>
> This seems true for the "invoked by ./configure or make" set. However:
>
> scripts/qemu-gdb.py:20:import gdb
> scripts/qemugdb/aio.py:13:import gdb
> scripts/qemugdb/coroutine.py:16:import gdb
> scripts/qemugdb/mtree.py:18:import gdb
>
> I just checked gdb8 and can't confirm python3 build works.

Yes, this is a GDB extension written in Python.  The gdb module is
available in the interpreter environment that GDB sets up.

Even if GDB doesn't support Python 3 yet, they will eventually.  It's
okay if we cannot add Python 3 support to these scripts yet.

> Also another 3rd party (python3 compliant):
>
> scripts/analyze-migration.py:20:import numpy as np

Weird, this script seems to use numpy APIs for unpacking binary data
instead of the standard library struct module.  As far as I can tell
the usual numpy functionality isn't actually used.  It should be easy
to drop the numpy dependency.

> Off-topic but we might document how to install dependencies for those
> scripts?

The analyze-migration.py script doesn't have any documentation, AFAIK.

Stefan
