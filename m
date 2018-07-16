Received: from eggs.gnu.org ([2001:4830:134:3::10]:38313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff4L1-00025l-Iw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:18:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1ff4L0-0004up-H9
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 10:18:55 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1531415537-26037-1-git-send-email-thuth@redhat.com>
Date: Mon, 16 Jul 2018 16:18:45 +0200
In-Reply-To: <1531415537-26037-1-git-send-email-thuth@redhat.com> (Thomas
	Huth's message of "Thu, 12 Jul 2018 19:12:17 +0200")
Message-ID: <87zhyrgt6i.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH] hw/arm/bcm2836: Mark the bcm2836 / bcm2837
 devices with user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Thomas Huth <thuth@redhat.com> writes:

> These devices are currently causing some problems when a user is trying
> to hot-plug or introspect them during runtime. Since these devices can
> not be instantiated by the user at all (they need to be wired up in code
> instead), we should mark them with user_creatable = false anyway, then we
> avoid at least the crashes with the hot-plugging. The introspection problem
> will be handled by a separate patch.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/bcm2836.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> index 6805a7d..45d9e40 100644
> --- a/hw/arm/bcm2836.c
> +++ b/hw/arm/bcm2836.c
> @@ -185,6 +185,8 @@ static void bcm283x_class_init(ObjectClass *oc, void *data)
>      bc->info = data;
>      dc->realize = bcm2836_realize;
>      dc->props = bcm2836_props;
> +    /* Reason: Must be wired up in code (see raspi_init() function) */
> +    dc->user_creatable = false;
>  }
>  
>  static const TypeInfo bcm283x_type_info = {

A more common way to phrase this is

       /* Reason: needs to be wired-up by raspi_init() */

If you you expect other functions to wire this one up in the future,
insert ", e.g." before "by".

I like consistency in such things, but it's matter of taste, thus:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
