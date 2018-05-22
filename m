Received: from eggs.gnu.org ([2001:4830:134:3::10]:51052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLGLg-0005Kl-Mn
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLGLd-0000tJ-HN
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:05:44 -0400
Received: from mail-qk0-x243.google.com ([2607:f8b0:400d:c09::243]:41710)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fLGLd-0000tD-Bg
	for qemu-devel@nongnu.org; Tue, 22 May 2018 19:05:41 -0400
Received: by mail-qk0-x243.google.com with SMTP id d125-v6so15997296qkb.8
	for <qemu-devel@nongnu.org>; Tue, 22 May 2018 16:05:41 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20180509060104.4458-1-f4bug@amsat.org>
	<20180509060104.4458-4-f4bug@amsat.org>
	<CAFEAcA8Qm_CQFGUbFNc27fyetggt6AjfhCXxZkU3fnbMibzLFw@mail.gmail.com>
	<69558af9-33da-0524-844d-10d4b4fb2ee3@amsat.org>
Message-ID: <f6ba5823-c1e4-c2ab-fa28-5d74d68d0cd3@amsat.org>
Date: Tue, 22 May 2018 20:05:26 -0300
MIME-Version: 1.0
In-Reply-To: <69558af9-33da-0524-844d-10d4b4fb2ee3@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 3/4] sdcard: Implement the UHS-I
 SWITCH_FUNCTION entries (Spec v3)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Alistair Francis <alistair@alistair23.me>, QEMU Developers <qemu-devel@nongnu.org>

On 05/22/2018 02:11 AM, Philippe Mathieu-Daudé wrote:
> On 05/14/2018 12:38 PM, Peter Maydell wrote:
>> On 9 May 2018 at 07:01, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>> [based on a patch from Alistair Francis <alistair.francis@xilinx.com>
>>>  from qemu/xilinx tag xilinx-v2015.2]
>>> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
>>> [PMD: rebased, changed magic by definitions, use stw_be_p, add tracing,
>>>  check all functions in group are correct before setting the values]
>>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
>>> ---
>>
>>> +    /* Bits 376-399: function (4 bits each group)
>>> +     *
>>> +     * Do not write the values back directly:
>>> +     * Check everything first writing to 'tmpbuf'
>>> +     */
>>> +    data_p = tmpbuf;
>>
>> You don't need a tmpbuf here, because it doesn't matter if we
>> write something to the data array that it turns out we don't want
>> to write; we can always rewrite it later...
>>
>>> +    for (fn_grp = SD_FG_MAX; fn_grp >= SD_FG_MIN; fn_grp--) {
>>> +        new_func = (arg >> ((fn_grp - 1) * 4)) & 0x0f;
>>> +        if (new_func == SD_FN_NO_INFLUENCE) {
>>> +            /* Guest requested no influence, so this function group
>>> +             * stays the same.
>>> +             */
>>> +            new_func = sd->function_group[fn_grp - 1];
>>> +        } else {
>>> +            const sd_fn_support *def = &sd_fn_support_defs[fn_grp][new_func];
>>> +            if (mode) {
>>> +                if (!def->name) {
>>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>>> +                                  "Function %d not valid for "
>>> +                                  "function group %d\n",
>>> +                                  new_func, fn_grp);
>>> +                    invalid_function_selected = true;
>>> +                    new_func = SD_FN_NO_INFLUENCE;
>>> +                } else if (def->unimp) {
>>> +                    qemu_log_mask(LOG_UNIMP,
>>> +                                  "Function %s (fn grp %d) not implemented\n",
>>> +                                  def->name, fn_grp);
>>> +                    invalid_function_selected = true;
>>> +                    new_func = SD_FN_NO_INFLUENCE;
>>> +                } else if (def->uhs_only && !sd->uhs_activated) {
>>> +                    qemu_log_mask(LOG_GUEST_ERROR,
>>> +                                  "Function %s (fn grp %d) only "
>>> +                                  "valid in UHS mode\n",
>>> +                                  def->name, fn_grp);
>>> +                    invalid_function_selected = true;
>>> +                    new_func = SD_FN_NO_INFLUENCE;
>>> +                } else {
>>> +                    sd->function_group[fn_grp - 1] = new_func;
>>
>> ...but don't want to update the function_group[n] to the new value until
>> we've checked that all the selected values in the command are OK,
>> so you either need a temporary for the new function values, or
>> you need to do one pass over the inputs to check and another one to set.
>>
>>> +                }
>>> +            }
>>> +            trace_sdcard_function_select(def->name, sd_fn_grp_name[fn_grp],
>>> +                                         mode);
>>> +        }
>>> +        if (!(fn_grp & 0x1)) { /* evens go in high nibble */
>>> +            *data_p = new_func << 4;
>>> +        } else { /* odds go in low nibble */
>>> +            *(data_p++) |= new_func;
>>> +        }
>>> +    }
>>> +    if (invalid_function_selected) {
>>> +        /* Ignore all the set values */
>>> +        memset(&sd->data[14], 0, SD_FN_BUFSZ);
>>
>> All-zeroes doesn't seem to match the spec. The spec says "The response
>> to an invalid selection of function will be 0xF", which is a bit unclear,
>> but has to mean at least that we return 0xf for the function groups which
>> were invalid selections. I'm not sure what we should return as status
>> for the function groups which weren't invalid; possibilities include:
>>  * 0xf
>>  * whatever the provided argument for that function group was
>>  * whatever the current status for that function group is
> If selection is 0xF (No influence) to query, response is
> "whatever the current status for that function group is"
> per group.

Select:
Current Limit: 400mA (function name 1 to group No 4, arg slice [15:12]),
Command system: Vendor specific (function name 0xF to group No 2, arg
slice [7:4])

(gdb) p/x (1 << 31) | (1 << 12) | (0xf << 4)
0x800010f0
>>> do_cmd(6, 0x800010f0)
SWITCH_FUNC CMD06(0x800010f0) crc7:0xb7
00008001800180018001c001800100f00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008120

0000 // 0mA
8001 //6
8001 //5
8001 //4
8001 //3
c001 //2
8001 //1
0 //6
0 //5
f //function group 4 "0xF shows function set error with the argument."
0 //3
0 //function group 2 "The function which is result of the switch command"
0 //1
00 // v0

So the function 0xF of group No 2 was not selected.

--

Now let's try with 2 invalid functions (3 for group 3, 9 for group 2).

(gdb) p/x (1 << 31) | (0 << 12) | (0x3 << 8) | (0x9 << 4)
0x80000390

>>> do_cmd(6, 0x80000390)
SWITCH_FUNC CMD06(0x80000390) crc7:0x53
0000
8001
8001
8001
8001
c001
8001
0 //6
0 //5
0 //4
f //function group 3 "0xF shows function set error with the argument"
f //function group 2 "0xF shows function set error with the argument"
0 //1
00 // v0

--

Group 1 & 2 with valid selection, group 3 invalid (0x3):

(gdb) p/x (1 << 31) | (0x3 << 8) | (0xE << 4) | (0xf << 0)
0x800003ef

>>> do_cmd(6, 0x800003ef)
SWITCH_FUNC CMD06(0x800003ef) crc7:0x23
00008001800180018001c0018001000f0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000001431

0000
8001
8001
8001
8001
c001
8001
0 //6
0 //5
0 //4
f //function group 3 "0xF shows function set error with the argument"
0 //2
0 //1
00 // v0

> 
>>
>> I don't suppose you're in a position to find out what an actual
>> hardware SD card does?
> 
> I tested some SanDisk 'Ultra' card.
> 
> Tests output posted on this thread:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-05/msg04840.html
> 
> I'll now rework sd_function_switch() before to respin.
