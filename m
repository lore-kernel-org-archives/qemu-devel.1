Received: from eggs.gnu.org ([2001:4830:134:3::10]:41571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ef3l2-0000OK-RC
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:09:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ef3l1-0002vn-Qz
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 08:09:28 -0500
References: <1516732013-18272-1-git-send-email-walling@linux.vnet.ibm.com>
	<1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <23ff4a42-e0e7-9a33-d516-5c40cbd61c3b@redhat.com>
Date: Fri, 26 Jan 2018 11:44:02 +0100
MIME-Version: 1.0
In-Reply-To: <1516732013-18272-10-git-send-email-walling@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 09/10] s390-ccw: read user input for
 boot index via the SCLP console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, frankja@linux.vnet.ibm.com, cohuck@redhat.com, david@redhat.com, alifm@linux.vnet.ibm.com

On 23.01.2018 19:26, Collin L. Walling wrote:
> Implements an sclp_read function to capture input from the
> console and a wrapper function that handles parsing certain
> characters and adding input to a buffer. The input is checked
> for any erroneous values and is handled appropriately.
>=20
> A prompt will persist until input is entered or the timeout
> expires (if one was set). Example:
>=20
>     Please choose (default will boot in 10 seconds):
>=20
> Correct input will boot the respective boot index. If the
> user's input is empty, 0, or if the timeout expires, then
> the default zipl entry will be chosen. If the input is
> within the range of available boot entries, then the
> selection will be booted. Any erroneous input will cancel
> the timeout and re-prompt the user.
>=20
> Signed-off-by: Collin L. Walling <walling@linux.vnet.ibm.com>
> ---
>  pc-bios/s390-ccw/menu.c     | 152 ++++++++++++++++++++++++++++++++++++=
+++++++-
>  pc-bios/s390-ccw/s390-ccw.h |   2 +
>  pc-bios/s390-ccw/sclp.c     |  20 ++++++
>  pc-bios/s390-ccw/virtio.c   |   2 +-
>  4 files changed, 172 insertions(+), 4 deletions(-)
[...]
> +static int read_prompt(char *buf, size_t len)
> +{
> +    char inp[2] =3D {};
> +    uint8_t idx =3D 0;
> +    uint64_t time;
> +
> +    if (timeout) {
> +        time =3D get_clock() + (timeout * TOD_CLOCK_SECOND);

Nit: Parentheses around "timeout * TOD_CLOCK_SECOND" are not required.

Apart from that, patch looks fine to me now.

Reviewed-by: Thomas Huth <thuth@redhat.com>
