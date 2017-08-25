Received: from eggs.gnu.org ([2001:4830:134:3::10]:36829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dlD6o-0005jU-3e
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:49:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dlD6j-0002Nu-ME
	for qemu-devel@nongnu.org; Fri, 25 Aug 2017 07:49:06 -0400
References: <1503661569-11408-1-git-send-email-frederic.konrad@adacore.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <658d99c8-47ce-9aeb-4187-3b1e3fccffc4@redhat.com>
Date: Fri, 25 Aug 2017 13:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <1503661569-11408-1-git-send-email-frederic.konrad@adacore.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-2.11] aux-to-i2c-bridge: don't allow
 user to create one
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: KONRAD Frederic <frederic.konrad@adacore.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org

On 25.08.2017 13:46, KONRAD Frederic wrote:
> This device is private and is created once per aux-bus.
> So don't allow the user to create one from command-line.
> 
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: KONRAD Frederic <frederic.konrad@adacore.com>
> ---
>  hw/misc/auxbus.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
> index 8a90ddd..1182745 100644
> --- a/hw/misc/auxbus.c
> +++ b/hw/misc/auxbus.c
> @@ -210,6 +210,16 @@ struct AUXTOI2CState {
>      I2CBus *i2c_bus;
>  };
>  
> +static void aux_bridge_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +
> +    /* This device is private and is created only once for each
> +     * aux-bus in aux_init_bus(..). So don't allow the user to add one.
> +     */
> +    dc->user_creatable = false;
> +}
> +
>  static void aux_bridge_init(Object *obj)
>  {
>      AUXTOI2CState *s = AUXTOI2C(obj);
> @@ -225,6 +235,7 @@ static inline I2CBus *aux_bridge_get_i2c_bus(AUXTOI2CState *bridge)
>  static const TypeInfo aux_to_i2c_type_info = {
>      .name = TYPE_AUXTOI2C,
>      .parent = TYPE_DEVICE,
> +    .class_init = aux_bridge_class_init,
>      .instance_size = sizeof(AUXTOI2CState),
>      .instance_init = aux_bridge_init
>  };
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>
