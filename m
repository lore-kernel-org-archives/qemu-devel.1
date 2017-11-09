Received: from eggs.gnu.org ([2001:4830:134:3::10]:59377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCo81-0001vd-Fi
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:48:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eCo7y-0006Bn-Eb
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 09:48:25 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1510181732.git.alistair.francis@xilinx.com>
	<da0b12a6c412264bdd5936380f90d6614e6692fc.1510181732.git.alistair.francis@xilinx.com>
	<8cce9ff0-1c9f-548f-77af-d0c2f5ab4d94@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9f4a8516-8ea0-6d8a-1acb-f0d6cc263884@amsat.org>
Date: Thu, 9 Nov 2017 11:48:04 -0300
MIME-Version: 1.0
In-Reply-To: <8cce9ff0-1c9f-548f-77af-d0c2f5ab4d94@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 04/45] tests: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, armbru@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, alistair23@gmail.com, Igor Mammedov <imammedo@redhat.com>

On 11/09/2017 11:38 AM, Eric Blake wrote:
> On 11/08/2017 04:56 PM, Alistair Francis wrote:
[...]
>> exit(-1); } qemu_thread_create(&threads[n_threads], "test", func,
>> &data[n_threads], @@ -417,7 +418,7 @@ static void
>> gtest_stress_10_5(void)
>> 
>> static void usage(int argc, char *argv[]) { -    fprintf(stderr,
>> "Usage: %s [nreaders [ perf | stress ] ]\n", argv[0]); +
>> error_report("Usage: %s [nreaders [ perf | stress ] ]",
>> argv[0]); exit(-1);
> 
> Separate patch - but 'exit(-1)' is almost always wrong (it gives
> status 255 through wait()/waitpid(); meanwhile waitid() is required
> by POSIX to get at the full 32-bit value except that Linux doesn't
> obey that requirement).  A process where wait() returns 255 makes
> xargs behave differently.  We really want exit(1).

$ git grep 'exit(-' origin/master | wc -l
60

Candidate for another mechanical patch?

> 
>> +++ b/tests/tcg/linux-test.c @@ -51,7 +51,7 @@ void error1(const
>> char *filename, int line, const char *fmt, ...) va_start(ap,
>> fmt); fprintf(stderr, "%s:%d: ", filename, line); 
>> vfprintf(stderr, fmt, ap); -    fprintf(stderr, "\n"); +
>> error_report("");
> 
> Umm, a blank line is not a useful error.  This hunk is bogus; we 
> probably want to stick with fprintf() for the entire message.

=)
