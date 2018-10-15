Received: from eggs.gnu.org ([2001:4830:134:3::10]:39207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8wR-00022q-DW
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gC8wQ-00063j-Of
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 15:54:15 -0400
Date: Mon, 15 Oct 2018 16:53:43 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181015195343.GA31060@habkost.net>
References: <20181015141453.32632-1-mreitz@redhat.com>
	<20181015141453.32632-4-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181015141453.32632-4-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/9] iotests: Use Python byte strings where
 appropriate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Cleber Rosa <crosa@redhat.com>

On Mon, Oct 15, 2018 at 04:14:47PM +0200, Max Reitz wrote:
> Since byte strings are no longer the default in Python 3, we have to
> explicitly use them where we need to, which is mostly when working with
> structures.  It also means that we need to open a file in binary mode
> when we want to use structures.
> 
> On the other hand, we have to accomodate for the fact that some
> functions (still) work with byte strings but we want to use unicode
> strings (in Python 3 at least, and it does not matter in Python 2).
> This includes base64 encoding, but it is most notable when working with
> the subprocess module: Either we set univeral_newlines to True so that
> the default streams are opened in text mode (hence this parameter is
> aliased as "text" as of 3.7), or, if that is not possible, we have to
> decode the output to a normal string.
> 
> Signed-off-by: Max Reitz <mreitz@redhat.com>
[...]
> diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
> index 9e0cad76f9..1225334cb8 100755
> --- a/tests/qemu-iotests/149
> +++ b/tests/qemu-iotests/149
> @@ -79,7 +79,7 @@ class LUKSConfig(object):
>  
>      def first_password_base64(self):
>          (pw, slot) = self.first_password()
> -        return base64.b64encode(pw)
> +        return base64.b64encode(pw.encode('ascii')).decode('ascii')

Would we want to have a test case for non-ascii passwords in the
future?  In that case you would probably need to make
self.passwords[] contain byte strings instead of text.

In either case, using 'ascii' as the encoding everywhere will
ensure the code will not try to be too smart about string
encodings if that happens.  I like that.

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

-- 
Eduardo
