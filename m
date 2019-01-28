Received: from eggs.gnu.org ([209.51.188.92]:58668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2rp-0004al-LW
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:06:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1go2ro-00083P-SI
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:06:09 -0500
References: <20190127100215.12584-1-sourav.jb1988@gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <758ce56b-4a03-405f-b668-f81094bec147@redhat.com>
Date: Mon, 28 Jan 2019 10:06:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190127100215.12584-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH] hw/input/adb.c: set device
 category of adb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au

On 2019-01-27 11:02, kumar sourav wrote:
> Sets the category of adb as DEVICE_CATEGORY_INPUT
> Devices should be assigned to one of DEVICE_CATEGORY_XXXX
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
> ---
>  hw/input/adb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/input/adb.c b/hw/input/adb.c
> index bbb40aeef1..6ca7c5641c 100644
> --- a/hw/input/adb.c
> +++ b/hw/input/adb.c
> @@ -126,6 +126,7 @@ static void adb_device_class_init(ObjectClass *oc, void *data)
>      dc->realize = adb_device_realizefn;
>      dc->props = adb_device_properties;
>      dc->bus_type = TYPE_ADB_BUS;
> +    set_bit(DEVICE_CATEGORY_INPUT, dc->categories);
>  }

This patch does not make too much sense in its current shape:
TYPE_ADB_DEVICE is an abstract device and does not show up in the output
of "-device help", so it is not necessary for this device itself.

Looking at the "child" devices adb-kdb and adb-mouse, they bother
already set DEVICE_CATEGORY_INPUT in their own, so they are already fine.

Thus please do one of the following:

1) Simply drop this patch.

2) Keep setting the category here in the abstract parent class, but then
also remove the DEVICE_CATEGORY_INPUT in the adb-kdb and adb-mouse child
classes.

 Thomas
