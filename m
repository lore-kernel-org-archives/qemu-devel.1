Received: from eggs.gnu.org ([2001:4830:134:3::10]:50739)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVgDR-0001M9-IF
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:39:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dVgDO-0001Ys-9J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:39:45 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38614)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dVgDO-0001YS-1J
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 11:39:42 -0400
Received: by mail-wm0-f42.google.com with SMTP id f67so30245052wmh.1
	for <qemu-devel@nongnu.org>; Thu, 13 Jul 2017 08:39:41 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87lgnt99xz.fsf@dusky.pond.sub.org>
References: <1499788408-10096-1-git-send-email-peter.maydell@linaro.org>
	<1499788408-10096-3-git-send-email-peter.maydell@linaro.org>
	<87lgnt99xz.fsf@dusky.pond.sub.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Jul 2017 16:38:20 +0100
Message-ID: <CAFEAcA-oEZZgPDOayLpZ1_aC0hEeOcYBL3+XejtJXnt4wDyqow@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, "patches@linaro.org" <patches@linaro.org>

On 12 July 2017 at 12:22, Markus Armbruster <armbru@redhat.com> wrote:
> Peter Maydell <peter.maydell@linaro.org> writes:
>
>> In some situations it's useful to have a qdev property which doesn't
>> automatically set its default value when qdev_property_add_static is
>> called (for instance when the default value is not constant).
>>
>> Support this by adding a flag to the Property struct indicating
>> whether to set the default value.  This replaces the existing test
>> for whether the PorpertyInfo set_default_value function pointer is
>
> PropertyInfo
>
>> NULL, and we set the .set_default field to true for all those cases
>> of struct Property which use a PropertyInfo with a non-NULL
>> set_default_value, so behaviour remains the same as before.
>>
>> We define two new macros DEFINE_PROP_SIGNED_NODEFAULT and
>> DEFINE_PROP_UNSIGNED_NODEFAULT, to cover the most plausible use cases
>> of wanting to set an integer property with no default value.
>
> Your text makes me wonder what is supposed to set the default value
> then.  Glancing ahead to PATCH 3, it looks like method instance_init()
> is.  Can you think of a scenario where something else sets it?

OK, proposed extra paragraph for commit message:

This gives us the semantics of:
 * if .set_default is true and .info->set_default_value is not NULL,
   then .defval is used as the the default value of the property
 * otherwise, the property system does not set any default, and
   the field will retain whatever initial value it was given by
   the device's .instance_init method

(to go just before the "We define two new macros..." para.)

>> --- a/include/hw/qdev-core.h
>> +++ b/include/hw/qdev-core.h
>> @@ -226,6 +226,7 @@ struct Property {
>>      PropertyInfo *info;
>>      ptrdiff_t    offset;
>>      uint8_t      bitnr;
>> +    bool         set_default;
>
> Your chance to add the very first comment to struct Property (its
> existing undocumentedness is an embarrassment, but not this patch's
> problem).  Let's write down that this flag governs where (integer)
> default values come from, either from member devfal or from method
> instance_init() or whatever.

OK, how about
/**
 * Property:
 * @set_default: true if the default value should be set from @defval
 *    (if false then no default value is set by the property system
 *     and the field retains whatever value it was given by instance_init).
 * @defval: default value for the property. This is used only if @set_default
 *     is true and @info->set_default_value is not NULL.
 */

?

thanks
-- PMM
