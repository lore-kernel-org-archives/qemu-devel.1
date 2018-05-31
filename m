Received: from eggs.gnu.org ([2001:4830:134:3::10]:43559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOJ8C-00020X-RQ
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:40:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fOJ8B-0005qR-S4
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:40:24 -0400
Received: from mail-ot0-x244.google.com ([2607:f8b0:4003:c0f::244]:36764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fOJ8B-0005px-Ld
	for qemu-devel@nongnu.org; Thu, 31 May 2018 04:40:23 -0400
Received: by mail-ot0-x244.google.com with SMTP id m11-v6so24406174otf.3
	for <qemu-devel@nongnu.org>; Thu, 31 May 2018 01:40:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <F7609DAE-0BEF-4384-BB0A-570B8BF4EFE7@gmail.com>
References: <20180529181523.19185-1-peter.maydell@linaro.org>
	<F7609DAE-0BEF-4384-BB0A-570B8BF4EFE7@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 May 2018 09:40:02 +0100
Message-ID: <CAFEAcA8kz3C9rT91=QMMbxmFL_vQivM_FEDWoz_or9xoxK3KvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2] ui/cocoa: Suppress
 NSFileHandlingPanelOKButton deprecation warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Programmingkid <programmingkidx@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 29 May 2018 at 19:23, Programmingkid <programmingkidx@gmail.com> wrote:
>
>> On May 29, 2018, at 2:15 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
>>
>> OSX 10.13 deprecates the NSFileHandlingPanelOKButton constant, and
>> would rather you use NSModalResponseOK, which was introduced in OS 10.9.
>> Use the recommended new constant name, with a backward compatibility
>> define if we're building on an older OSX.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> v1->v2: define MAC_OS_X_VERSION_10_9 if the system headers don't;
>> fixes compilation on versions before 10.9.
>> ---
>> ui/cocoa.m | 12 +++++++++++-
>> 1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index 110b393e4e..2991ed4f19 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -44,6 +44,9 @@
>> #ifndef MAC_OS_X_VERSION_10_6
>> #define MAC_OS_X_VERSION_10_6 1060
>> #endif
>> +#ifndef MAC_OS_X_VERSION_10_9
>> +#define MAC_OS_X_VERSION_10_9 1090
>> +#endif
>> #ifndef MAC_OS_X_VERSION_10_10
>> #define MAC_OS_X_VERSION_10_10 101000
>> #endif
>> @@ -79,6 +82,13 @@
>> #define NSWindowStyleMaskMiniaturizable NSMiniaturizableWindowMask
>> #define NSWindowStyleMaskTitled         NSTitledWindowMask
>> #endif
>> +/* 10.13 deprecates NSFileHandlingPanelOKButton in favour of
>> + * NSModalResponseOK, which was introduced in 10.9. Define
>> + * it for older versions.
>> + */
>> +#if MAC_OS_X_VERSION_MAX_ALLOWED < MAC_OS_X_VERSION_10_9
>> +#define NSModalResponseOK NSFileHandlingPanelOKButton
>> +#endif
>>
>> //#define DEBUG
>>
>> @@ -1218,7 +1228,7 @@ QemuCocoaView *cocoaView;
>>     [openPanel setCanChooseFiles: YES];
>>     [openPanel setAllowsMultipleSelection: NO];
>>     [openPanel setAllowedFileTypes: supportedImageFileTypes];
>> -    if([openPanel runModal] == NSFileHandlingPanelOKButton) {
>> +    if([openPanel runModal] == NSModalResponseOK) {
>>         NSString * file = [[[openPanel URLs] objectAtIndex: 0] path];
>>         if(file == nil) {
>>             NSBeep();
>> --
>> 2.17.0
>>
>
> It works :)
>
> Reviewed-by: John Arbuckle <programmingkidx@gmail.com>

Thanks; applied this version to master.

-- PMM
