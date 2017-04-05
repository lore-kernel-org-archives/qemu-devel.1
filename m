Received: from eggs.gnu.org ([2001:4830:134:3::10]:47481)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvruk-0007ts-8t
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:52:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1cvruj-0005Z8-GD
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 16:52:26 -0400
References: <20170405194741.18956-1-eblake@redhat.com>
	<20170405194741.18956-13-eblake@redhat.com>
From: John Snow <jsnow@redhat.com>
Message-ID: <cf7bf2dd-32ee-baf2-b963-177c4aff8c52@redhat.com>
Date: Wed, 5 Apr 2017 16:52:18 -0400
MIME-Version: 1.0
In-Reply-To: <20170405194741.18956-13-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 12/13] fdc-test: Avoid deprecated
 'change' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, "open list:Floppy" <qemu-block@nongnu.org>



On 04/05/2017 03:47 PM, Eric Blake wrote:
> Use the preferred blockdev-change-medium command instead.
> 
> Admittedly, use of 'device' is also deprecated over the newer use
> of 'id', but the test is exploiting that the name 'floppy0' is
> auto-created by the board, and I could not figure out where the
> command line lives that would need to be tweaked to provide a
> non-random 'id' to this device.
> 

qtest_start
  qtest_init
    qtest_init_without_qmp_handshake

You can give *extra* args to qtest_start, but depending on the board
-nodefaults isn't going to get rid of that embedded FDC nor its default
floppy0 drive, I think.

You could perhaps add a second floppy drive explicitly with
-device floppy,id=snafu,bus=floppy-bus.0,unit=1

and then interact with this non-default drive, or you could use Q35 and
-nodefaults to fully clear the isa-fdc, then re-add with

-device isa-fdc,id=foobar
-device floppy,bus=foobar.0,unit=1

Or you could do nothing, and I won't tell anyone.

--js

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> ---
> v3: update commit message to point out that we are still using
> deprecated 'device'
> ---
>  tests/fdc-test.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/fdc-test.c b/tests/fdc-test.c
> index 738c6b4..f5ff68d 100644
> --- a/tests/fdc-test.c
> +++ b/tests/fdc-test.c
> @@ -298,8 +298,9 @@ static void test_media_insert(void)
> 
>      /* Insert media in drive. DSKCHK should not be reset until a step pulse
>       * is sent. */
> -    qmp_discard_response("{'execute':'change', 'arguments':{"
> -                         " 'device':'floppy0', 'target': %s, 'arg': 'raw' }}",
> +    qmp_discard_response("{'execute':'blockdev-change-medium', 'arguments':{"
> +                         " 'device':'floppy0', 'filename': %s, "
> +                         "'format': 'raw' }}",
>                           test_image);
> 
>      dir = inb(FLOPPY_BASE + reg_dir);
> 
