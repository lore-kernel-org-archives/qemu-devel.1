Received: from eggs.gnu.org ([2001:4830:134:3::10]:41668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVFiz-00073f-1X
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1dVFix-0006R0-Lx
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 07:22:33 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
Date: Wed, 12 Jul 2017 13:22:16 +0200
In-Reply-To: <1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
	(Peter Maydell's message of "Tue, 11 Jul 2017 16:53:27 +0100")
Message-ID: <87lgnt99xz.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/3] qdev: support properties which don't
 set a default value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?utf-8?Q?Marc-Andr?= =?utf-8?Q?=C3=A9?= Lureau <marcandre.lureau@redhat.com>, patches@linaro.org

Peter Maydell <peter.maydell@linaro.org> writes:

> In some situations it's useful to have a qdev property which doesn't
> automatically set its default value when qdev_property_add_static is
> called (for instance when the default value is not constant).
>
> Support this by adding a flag to the Property struct indicating
> whether to set the default value.  This replaces the existing test
> for whether the PorpertyInfo set_default_value function pointer is

PropertyInfo

> NULL, and we set the .set_default field to true for all those cases
> of struct Property which use a PropertyInfo with a non-NULL
> set_default_value, so behaviour remains the same as before.
>
> We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
> DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
> of wanting to set an integer property with no default value.

Your text makes me wonder what is supposed to set the default value
then.  Glancing ahead to PATCH 3, it looks like method instance_init()
is.  Can you think of a scenario where something else sets it?

> Suggested-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Since the previous patch fixed the only case that was
> using a default value but not explicitly setting .defval.[ui],
> this patch is a bit easier to review: .set_default = true
> is added in exactly the places that initialize .defval.[ui].
> ---
>  include/hw/qdev-core.h       |  1 +
>  include/hw/qdev-properties.h | 20 ++++++++++++++++++++
>  hw/core/qdev.c               |  2 +-
>  3 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
> index 9d7c1c0..d110163 100644
> --- a/include/hw/qdev-core.h
> +++ b/include/hw/qdev-core.h
> @@ -226,6 +226,7 @@ struct Property {
>      PropertyInfo *info;
>      ptrdiff_t    offset;
>      uint8_t      bitnr;
> +    bool         set_default;

Your chance to add the very first comment to struct Property (its
existing undocumentedness is an embarrassment, but not this patch's
problem).  Let's write down that this flag governs where (integer)
default values come from, either from member devfal or from method
instance_init() or whatever.

>      union {
>          int64_t i;
>          uint64_t u;
> diff --git a/include/hw/qdev-properties.h b/include/hw/qdev-properties.h
> index 36d040c..66816a5 100644
> --- a/include/hw/qdev-properties.h
> +++ b/include/hw/qdev-properties.h
> @@ -43,15 +43,24 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      = &(_prop),                                          \
>          .offset    = offsetof(_state, _field)                           \
>              + type_check(_type,typeof_field(_state, _field)),           \
> +        .set_default = true,                                            \
>          .defval.i  = (_type)_defval,                                    \
>          }

If you flip the sense of the flag, you don't need to mess with the
PropertyInfo, and don't need the note referring reviewers to the
previous patch.  However, the case "use .defval" already requires an
initializer, so adding one for .set_default seems fair.  Okay.

>  
> +#define DEFINE_PROP_SIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
> +        .name      = (_name),                                           \
> +        .info      = &(_prop),                                          \
> +        .offset    = offsetof(_state, _field)                           \
> +            + type_check(_type, typeof_field(_state, _field)),          \
> +        }
> +
>  #define DEFINE_PROP_BIT(_name, _state, _field, _bit, _defval) {  \
>          .name      = (_name),                                    \
>          .info      = &(qdev_prop_bit),                           \
>          .bitnr    = (_bit),                                      \
>          .offset    = offsetof(_state, _field)                    \
>              + type_check(uint32_t,typeof_field(_state, _field)), \
> +        .set_default = true,                                     \
>          .defval.u  = (bool)_defval,                              \
>          }
>  
> @@ -60,15 +69,24 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      = &(_prop),                                          \
>          .offset    = offsetof(_state, _field)                           \
>              + type_check(_type, typeof_field(_state, _field)),          \
> +        .set_default = true,                                            \
>          .defval.u  = (_type)_defval,                                    \
>          }
>  
> +#define DEFINE_PROP_UNSIGNED_NODEFAULT(_name, _state, _field, _prop, _type) { \
> +        .name      = (_name),                                           \
> +        .info      = &(_prop),                                          \
> +        .offset    = offsetof(_state, _field)                           \
> +            + type_check(_type, typeof_field(_state, _field)),          \
> +        }
> +
>  #define DEFINE_PROP_BIT64(_name, _state, _field, _bit, _defval) {       \
>          .name      = (_name),                                           \
>          .info      = &(qdev_prop_bit64),                                \
>          .bitnr    = (_bit),                                             \
>          .offset    = offsetof(_state, _field)                           \
>              + type_check(uint64_t, typeof_field(_state, _field)),       \
> +        .set_default = true,                                            \
>          .defval.u  = (bool)_defval,                                     \
>          }
>  
> @@ -77,6 +95,7 @@ extern PropertyInfo qdev_prop_arraylen;
>          .info      = &(qdev_prop_bool),                          \
>          .offset    = offsetof(_state, _field)                    \
>              + type_check(bool, typeof_field(_state, _field)),    \
> +        .set_default = true,                                     \
>          .defval.u    = (bool)_defval,                            \
>          }
>  
> @@ -110,6 +129,7 @@ extern PropertyInfo qdev_prop_arraylen;
>                            _arrayfield, _arrayprop, _arraytype) {        \
>          .name = (PROP_ARRAY_LEN_PREFIX _name),                          \
>          .info = &(qdev_prop_arraylen),                                  \
> +        .set_default = true,                                            \
>          .defval.u = 0,                                                  \
>          .offset = offsetof(_state, _field)                              \
>              + type_check(uint32_t, typeof_field(_state, _field)),       \
> diff --git a/hw/core/qdev.c b/hw/core/qdev.c
> index 849952a..96965a7 100644
> --- a/hw/core/qdev.c
> +++ b/hw/core/qdev.c
> @@ -793,7 +793,7 @@ void qdev_property_add_static(DeviceState *dev, Property *prop,
>                                      prop->info->description,
>                                      &error_abort);
>  
> -    if (prop->info->set_default_value) {
> +    if (prop->set_default) {
>          prop->info->set_default_value(obj, prop);
>      }
>  }

Preferably with a suitable comment on member set_default and an improved
commit message:
Reviewed-by: Markus Armbruster <armbru@redhat.com>
