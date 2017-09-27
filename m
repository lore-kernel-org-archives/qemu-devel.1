Received: from eggs.gnu.org ([2001:4830:134:3::10]:36651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxLSF-0001Qj-KS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dxLSE-0004pU-Ht
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 19:09:23 -0400
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20170926005520.GA7906@flamenco>
References: <cover.1506384414.git.alistair.francis@xilinx.com>
	<50c325943b1547813567efe6a11fb44644494d70.1506384414.git.alistair.francis@xilinx.com>
	<20170926005520.GA7906@flamenco>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 27 Sep 2017 16:08:50 -0700
Message-ID: <CAKmqyKP7b0OP35ctzOmkCwPH4sHQFZAKtyTRgPTYN0iSXkgsaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v1 2/8] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Alistair Francis <alistair.francis@xilinx.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Igor Mammedov <imammedo@redhat.com>

On Mon, Sep 25, 2017 at 5:55 PM, Emilio G. Cota <cota@braap.org> wrote:
> On Mon, Sep 25, 2017 at 17:08:48 -0700, Alistair Francis wrote:
>> diff --git a/tests/atomic_add-bench.c b/tests/atomic_add-bench.c
>> index caa1e8e689..41ba1600c0 100644
>> --- a/tests/atomic_add-bench.c
>> +++ b/tests/atomic_add-bench.c
>> @@ -29,7 +29,7 @@ static const char commands_string[] =
>>  static void usage_complete(char *argv[])
>>  {
>>      fprintf(stderr, "Usage: %s [options]\n", argv[0]);
>> -    fprintf(stderr, "options:\n%s\n", commands_string);
>> +    fprintf(stderr, "options:\n%s", commands_string);
>>  }
>
> We do want that trailing \n, unless we move it to commands_string.

Yeah, this was a mistake. It should have swapped to error_report().

>
> Also, I think using error_report here would be confusing -- this is a standalone
> test program with as little QEMU-specific knowledge as possible (QemuThreads
> are used for portability); using error_report here is confusing (this is not
> an error).

Do you mean in all tests/ sub directory or just a few certain cases?

>
>> diff --git a/tests/check-qlit b/tests/check-qlit
>> new file mode 100755
>> index 0000000000000000000000000000000000000000..950429524e3eb07e6daed1fe01caad0f5d554809
>> GIT binary patch
>> literal 272776
>> zcmeEvdwf*Ywf~vPB$){zGeCghJ;($So{10*LNEgfoIs*MKvBRDLV(l&F`3b5QKOS6
>
> ? I don't know what this is, I don't seem to have this binary in my
> checked out tree.

Yeah, this shouldn't be here.

Thanks,
Alistair

>
> (snips thousands of lines)
>
>> diff --git a/tests/qht-bench.c b/tests/qht-bench.c
>> index 11c1cec766..2637d601a9 100644
>> --- a/tests/qht-bench.c
>> +++ b/tests/qht-bench.c
>> @@ -5,6 +5,7 @@
>>   *   See the COPYING file in the top-level directory.
>>   */
>>  #include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu/processor.h"
>>  #include "qemu/atomic.h"
>>  #include "qemu/qht.h"
>> @@ -89,7 +90,7 @@ static const char commands_string[] =
>>  static void usage_complete(int argc, char *argv[])
>>  {
>>      fprintf(stderr, "Usage: %s [options]\n", argv[0]);
>> -    fprintf(stderr, "options:\n%s\n", commands_string);
>> +    fprintf(stderr, "options:\n%s", commands_string);
>
> Same as above: this removes the necessary trailing \n.
>
>>      exit(-1);
>>  }
>>
>> @@ -328,7 +329,7 @@ static void htable_init(void)
>>              retries++;
>>          }
>>      }
>> -    fprintf(stderr, " populated after %zu retries\n", retries);
>> +    error_report(" populated after %zu retries", retries);
>>  }
>
> ditto -- I'd rather keep fprintf(stderr) here, it's less confusing.
>
> Thanks,
>
>                 Emilio
