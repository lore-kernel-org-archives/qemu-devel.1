Received: from eggs.gnu.org ([2001:4830:134:3::10]:32917)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fyuzS-00039l-Dy
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 04:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fyuzR-00008G-H2
	for qemu-devel@nongnu.org; Sun, 09 Sep 2018 04:22:42 -0400
References: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <f7076ae9-da04-7dbc-8acf-ebe5b948c4ed@vivier.eu>
Date: Sun, 9 Sep 2018 10:22:23 +0200
MIME-Version: 1.0
In-Reply-To: <20180908182205.GB409@mornington.dcs.gla.ac.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] linux-user: write(fd, NULL,
 0) parity with linux's treatment of same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Garnock-Jones <tony.garnock-jones@glasgow.ac.uk>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, qemu-stable@nongnu.org

Le 08/09/2018 à 20:22, Tony Garnock-Jones a écrit :
> Bring linux-user write(2) handling into line with linux for the case
> of a 0-byte write with a NULL buffer. Based on a patch originally
> written by Zhuowei Zhang.
> 
> Addresses https://bugs.launchpad.net/qemu/+bug/1716292.
> 
> From Zhuowei Zhang's patch (https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg08073.html):
> 
>     Linux returns success for the special case of calling write with a
>     zero-length NULL buffer: compiling and running
> 
>     int main() {
>        ssize_t ret = write(STDOUT_FILENO, NULL, 0);
>        fprintf(stderr, "write returned %ld\n", ret);
>        return 0;
>     }
> 
>     gives "write returned 0" when run directly, but "write returned
>     -1" in QEMU.
> 
>     This commit checks for this situation and returns success if
>     found.
> 
> Subsequent discussion raised the following questions (and my answers):
> 
>  - Q. Should TARGET_NR_read pass through to safe_read in this
>       situation too?
>    A. I'm wary of changing unrelated code to the specific problem I'm
>       addressing. TARGET_NR_read is already consistent with Linux for
>       this case.
> 
>  - Q. Do pread64/pwrite64 need to be changed similarly?
>    A. Experiment suggests not: both linux and linux-user yield -1 for
>       NULL 0-length reads/writes.
> 
> Signed-off-by: Tony Garnock-Jones <tonygarnockjones@gmail.com>
> ---
>  linux-user/syscall.c | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
