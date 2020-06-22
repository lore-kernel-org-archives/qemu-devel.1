Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94DCFC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D93206E2
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 23:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D93206E2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnVYW-00029l-L8
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 19:08:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46998)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jnVXu-0001hg-Ku
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 19:08:10 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:46083)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jnVXr-0004Ii-Ar
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 19:08:09 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E3890746331;
 Tue, 23 Jun 2020 01:07:55 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 528B8746307; Tue, 23 Jun 2020 01:07:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5103074633D;
 Tue, 23 Jun 2020 01:07:55 +0200 (CEST)
Date: Tue, 23 Jun 2020 01:07:55 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 9/9] sm501: Fix and optimize overlap check
In-Reply-To: <CAFEAcA8J-CTYXxGEsuFF0Oc2DE-PuK3BYmosSSmRhQSCc5sjXQ@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2006230037160.52035@zero.eik.bme.hu>
References: <cover.1592686588.git.balaton@eik.bme.hu>
 <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
 <CAFEAcA8J-CTYXxGEsuFF0Oc2DE-PuK3BYmosSSmRhQSCc5sjXQ@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 19:07:56
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Aurelien Jarno <aurelien@aurel32.net>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020, Peter Maydell wrote:
> On Sat, 20 Jun 2020 at 22:04, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>>
>> When doing reverse blit we need to check if source and dest overlap
>> but it is not trivial due to possible different base and pitch of
>> source and dest. Do rectangle overlap if base and pitch match,
>> otherwise just check if memory area containing the rects overlaps so
>> rects could possibly overlap.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/display/sm501.c | 26 ++++++++++++++++----------
>>  1 file changed, 16 insertions(+), 10 deletions(-)
>>
>> diff --git a/hw/display/sm501.c b/hw/display/sm501.c
>> index 2db347dcbc..e7c69bf7fd 100644
>> --- a/hw/display/sm501.c
>> +++ b/hw/display/sm501.c
>> @@ -690,6 +690,7 @@ static void sm501_2d_operation(SM501State *s)
>>      unsigned int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
>>      int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
>>      int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
>> +    bool overlap = false;
>>
>>      if ((s->twoD_stretch >> 16) & 0xF) {
>>          qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
>> @@ -784,16 +785,21 @@ static void sm501_2d_operation(SM501State *s)
>>                           ldn_he_p(&s->local_mem[src_base + si], bypp));
>>                  break;
>>              }
>> -            /* Check for overlaps, this could be made more exact */
>> -            uint32_t sb, se, db, de;
>> -            sb = src_base + src_x + src_y * (width + src_pitch);
>> -            se = sb + width + height * (width + src_pitch);
>> -            db = dst_base + dst_x + dst_y * (width + dst_pitch);
>> -            de = db + width + height * (width + dst_pitch);
>> -            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
>> -                /* regions may overlap: copy via temporary */
>> -                int llb = width * bypp;
>> -                int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
>> +            /* If reverse blit do simple check for overlaps */
>> +            if (rtl && src_base == dst_base && src_pitch == dst_pitch) {
>> +                overlap = (src_x < dst_x + width && src_x + width > dst_x &&
>> +                           src_y < dst_y + height && src_y + height > dst_y);
>
> This part looks good...
>
>> +            } else if (rtl) {
>> +                unsigned int sb, se, db, de;
>> +                sb = src_base + (src_x + src_y * src_pitch) * bypp;
>> +                se = sb + (width + height * src_pitch) * bypp;
>> +                db = dst_base + (dst_x + dst_y * dst_pitch) * bypp;
>> +                de = db + (width + height * dst_pitch) * bypp;
>> +                overlap = (db >= sb && db <= se) || (de >= sb && de <= se);
>
> ...but this part I think the overlap calculation isn't right. Consider
> db=5, de=15, sb=10, se=12. This gives overlap=false but
> the two regions do overlap because [sb,se] is entirely inside [db,de].
> I think you want
>  overlap = (db < se && sb < de);
> (this is the same logic as each of the x/y range checks in the rectangle
> overlap test. put another way, if !(db<se) then we can't have an overlap
> because the dest range starts after the source range ends; similarly if
> !(sb<de) then the source range begins after the dest range ends and
> there's no overlap. So for an overlap to be possible we must have both
> db<se && sb<de.)

Thanks for checking it, you're right, I'll need to think about this again 
for a bit longer.

> Here I'm using a definition of the "end" de and se which is that they point
> to the byte *after* the last one used (ie that we're really working with
> "half-open" ranges [db, de)  and [sb, se) where de and se aren't in the
> range), because that's easier to calculate given that we need to account
> for bypp and it's more natural when dealing with "start, length" pairs.
>
> Also and less importantly (because it's wrong in the "safe" direction) I think
> your se and de are overestimates, because one-past-the-last-used-byte in each
> case is
>   sb + (width + (height-1) * src_pitch) * bypp
> (consider width=1 height=1, where one-past-the-last-used-byte is sb + bypp
> because there's only one pixel involved).

I'm not sure I follow the above but I had >= in the check to account for 
this although I've got the check wrong so that doesn't mean much.

What I've used is something like:

base               pitch
+------------------------------------------+
|        ^                                 |
|      y |                                 |
|   x    v      w                          |
|< - - ->+-------------+                   |
|        |             |                   |
|       h|             |                   |
|        |             |                   |
|        +-------------+                   |
|                                          |
+------------------------------------------+

then y * pitch * bypp is the index of the line + x * bypp is index of 
first point which gives:

sb = base + (x + y * pitch) * bypp

then add width * bypp to get past the rect (index of byte after as you say 
above), then moved h lines down that's h * pitch * bypp but maybe that's 
too much because we only want to get to the last line not past that. Then 
using h - 1 is enough.

>> +            }
>> +            if (overlap) {
>> +                /* pixman can't do reverse blit: copy via temporary */
>> +                int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
>>                  uint32_t *tmp = tmp_buf;
>>
>>                  if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
>
> PS: why do we care about overlap only for right-to-left blits and not
> left-to-right blits ?

I think I've already answered that here:

https://lists.nongnu.org/archive/html/qemu-devel/2020-05/msg07650.html

since pixman does left to right that should match the intended operation 
even with overlap when rtl is not set. (Rtl also seems to mean bottom to 
top as well because there's only this one bit for direction.)

Regards,
BALATON Zoltan

