Return-Path: <SRS0=ZRpO=43=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C93D5C10F27
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:47:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8412F215A4
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2020 14:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Zvyy28++"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8412F215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34557 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBgAN-00017T-Q4
	for qemu-devel@archiver.kernel.org; Tue, 10 Mar 2020 10:47:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51240)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liran.alon@oracle.com>) id 1jBg9P-0000Z5-Ft
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:46:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liran.alon@oracle.com>) id 1jBg9M-0005a6-8R
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:46:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:54638)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <liran.alon@oracle.com>)
 id 1jBg9L-0005Xs-Ty
 for qemu-devel@nongnu.org; Tue, 10 Mar 2020 10:46:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AEXbjh061395;
 Tue, 10 Mar 2020 14:46:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=subject : to : cc :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=ZIZm9zc8v3zWoNNOKlx1pME50t4C5799yI5AIcFj2TA=;
 b=Zvyy28++ObFsVC2T1XRhrWDemhLO1ojV/0chJ8Ywxe1V/JlghgRnW5J8rvc3tnLDWHXi
 l9X89UmzZ7HBTY6mpFE6l8BYQgzboKJOg/SPb/ALl1M8uJx970nBHcOvIMjBb/HawQ6A
 mnVVAA7J0mTTHfDHEk1E/YHW9XaWb+OLfVXmUALUwkmvLXX6OlUe+ICnVujngmUnlr2p
 uklWVw/PcPZS5naO08UighkwbWmqzJB++s9deO3NQs/Qu0fXlxDBS7wvlYnaSl3y9/5J
 B+MGgiSWNf3aVx1fSo9AgZXEdNI3L2zbohp4UuQt+z6u7Unt7MTIEtdOKQLZ0FAsXb/m Tg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2120.oracle.com with ESMTP id 2yp7hm2bu9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:46:25 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 02AEXb9r075654;
 Tue, 10 Mar 2020 14:46:24 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2yp8rj95c3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 10 Mar 2020 14:46:24 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 02AEkNFZ019491;
 Tue, 10 Mar 2020 14:46:23 GMT
Received: from Lirans-MacBook-Pro.local (/213.57.127.2)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 10 Mar 2020 07:46:23 -0700
Subject: Re: [PATCH 05/14] hw/i386/vmport: Report VMX type in CMD_GETVERSION
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200309235411.76587-1-liran.alon@oracle.com>
 <20200309235411.76587-6-liran.alon@oracle.com>
 <20200310081144-mutt-send-email-mst@kernel.org>
 <43b5d99e-70f2-39dc-1a12-e6c6d9e75d5a@oracle.com>
 <20200310082730-mutt-send-email-mst@kernel.org>
 <506ba498-ba50-9415-18b3-bcaff1561c55@oracle.com>
 <20200310084758-mutt-send-email-mst@kernel.org>
 <1f4766b2-9683-8ebf-752e-a0378bb0cbc3@oracle.com>
 <20200310094350-mutt-send-email-mst@kernel.org>
From: Liran Alon <liran.alon@oracle.com>
Message-ID: <6d3c248f-f8fe-754d-59e5-8f2740a55263@oracle.com>
Date: Tue, 10 Mar 2020 16:46:19 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200310094350-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2003100098
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9555
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 spamscore=0
 priorityscore=1501 clxscore=1015 mlxscore=0 impostorscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2003100098
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by userp2120.oracle.com id
 02AEXbjh061395
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
Cc: ehabkost@redhat.com, qemu-devel@nongnu.org,
 Nikita Leshenko <nikita.leshchenko@oracle.com>, pbonzini@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 10/03/2020 16:08, Michael S. Tsirkin wrote:
> On Tue, Mar 10, 2020 at 03:35:25PM +0200, Liran Alon wrote:
>> On 10/03/2020 14:53, Michael S. Tsirkin wrote:
>>> On Tue, Mar 10, 2020 at 02:43:51PM +0200, Liran Alon wrote:
>>>> On 10/03/2020 14:35, Michael S. Tsirkin wrote:
>>>>> On Tue, Mar 10, 2020 at 02:25:28PM +0200, Liran Alon wrote:
>>>>>> On 10/03/2020 14:14, Michael S. Tsirkin wrote:
>>>>>>> On Tue, Mar 10, 2020 at 01:54:02AM +0200, Liran Alon wrote:
>>>>>>>> As can be seen from VmCheck_GetVersion() in open-vm-tools code,
>>>>>>>> CMD_GETVERSION should return VMX type in ECX register.
>>>>>>>>
>>>>>>>> Default is to fake host as VMware ESX server. But user can contr=
ol
>>>>>>>> this value by "-global vmport.vmx-type=3DX".
>>>>>>>>
>>>>>>>> Reviewed-by: Nikita Leshenko <nikita.leshchenko@oracle.com>
>>>>>>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>>>>>>> ---
>>>>>>>>      hw/i386/vmport.c | 13 +++++++++++++
>>>>>>>>      1 file changed, 13 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/i386/vmport.c b/hw/i386/vmport.c
>>>>>>>> index a2c8ff4b59cf..c03f57f2f636 100644
>>>>>>>> --- a/hw/i386/vmport.c
>>>>>>>> +++ b/hw/i386/vmport.c
>>>>>>>> @@ -36,6 +36,15 @@
>>>>>>>>      #define VMPORT_ENTRIES 0x2c
>>>>>>>>      #define VMPORT_MAGIC   0x564D5868
>>>>>>>> +typedef enum {
>>>>>>>> +   VMX_TYPE_UNSET =3D 0,
>>>>>>>> +   VMX_TYPE_EXPRESS,    /* Deprecated type used for VMware Expr=
ess */
>>>>>>>> +   VMX_TYPE_SCALABLE_SERVER,    /* VMware ESX server */
>>>>>>>> +   VMX_TYPE_WGS,        /* Deprecated type used for VMware Serv=
er */
>>>>>>>> +   VMX_TYPE_WORKSTATION,
>>>>>>>> +   VMX_TYPE_WORKSTATION_ENTERPRISE /* Deprecated type used for =
ACE 1.x */
>>>>>>>> +} VMX_Type;
>>>>>>>> +
>>>>>>> Is this really VMX type? And do users care what it is?
>>>>>> This enum is copied from open-vm-tools source code
>>>>>> (lib/include/vm_version.h). This is how it's called in VMware Tool=
s
>>>>>> terminology... Don't blame me :)
>>>>> I don't even want to go look at it to check license compatibility, =
but
>>>>> IMHO that's just another reason to avoid copying it.
>>>>> Copying bad code isn't a good idea unless needed for
>>>>> compatibility.
>>>> Preserving original VMware terminology makes sense and is preferred =
in my
>>>> opinion. I think diverging from it is more confusing.
>>> Yea tell it to people who got in hot water because they copied
>>> some variable names to avoid confusion. Oh wait.
>>>
>>> This is not an official terminology I think.
>> Maybe it wasn't clear from my previous messages, but open-vm-tools is =
an
>> official VMware open-source project...
>> VMX is the official name of the VMware Userspace-VMM and VMX-Type is a=
n
>> official name as-well.
>>
>> I'm also not copying code here... I'm copying definitions from relevan=
t
>> header files to implement a compatible interface.
> You don't need to have enum have same names to be compatible.
> And in this case, all we really need is just a single number *2*
> and a comment saying that's ESX server.
I don't have to. I want to. It makes code much more clearer to reader. I=20
don't see any harm in that.
>
>> This is no different than copying constants from a Linux device driver=
 to
>> implement it's device emulation in QEMU.
> We really try to avoid stuff like this. If one does this one has to
> check license etc etc.
There is no license issue here. It's only definitions. And if you really=20
wonder about it, this is the license written in the header files of=20
open-vm-tools:
/*********************************************************
 =C2=A0* Copyright (C) 2006 VMware, Inc. All rights reserved.
 =C2=A0*
 =C2=A0* This program is free software; you can redistribute it and/or mo=
dify it
 =C2=A0* under the terms of the GNU Lesser General Public License as publ=
ished
 =C2=A0* by the Free Software Foundation version 2.1 and no later version.
 =C2=A0*
 =C2=A0* This program is distributed in the hope that it will be useful, =
but
 =C2=A0* WITHOUT ANY WARRANTY; without even the implied warranty of=20
MERCHANTABILITY
 =C2=A0* or FITNESS FOR A PARTICULAR PURPOSE.=C2=A0 See the Lesser GNU Ge=
neral Public
 =C2=A0* License for more details.
 =C2=A0*
 =C2=A0* You should have received a copy of the GNU Lesser General Public=
 License
 =C2=A0* along with this program; if not, write to the Free Software=20
Foundation, Inc.,
 =C2=A0* 51 Franklin St, Fifth Floor, Boston, MA=C2=A0 02110-1301 USA.
 =C2=A0*
 =C2=A0*********************************************************/
> But in this case, the names are confusing,
> violate our coding style, I could go on.
The only thing that violates the coding style is "VMX_Type" enum type=20
name instead of "VMXType". And that is right and I will change it in v2.=20
However, the rest doesn't violate coding style.
In addition, I disagree this is confusing. These are official VMX=20
product names defined by VMware. I don't see any value in renaming them.=20
It just results in additional confusion.
>
>
>>> So please just make it make sense by itself, and make it
>>> easy to research.
>> I think I have made it the most easiest to research. Having exactly sa=
me
>> names as VMware official project and pointing to it directly from comm=
ents
>> and commit messages.
> What good does this do when that code will change tomorrow?
Why would the enum constants change tomorrow?
And even if that will happen, it still allows a reader to just search in=20
Google the name of the constant and find results.
Which is better than just making up names that we think our more=20
intuitive than the names VMware decided for their own product.
>
> You worry about code being easy to write, I worry about it
> being easy to read.

No I don't. This doesn't matter at all for writing code but matters only=20
to reading it.

>
> Here are things we can do to make things easier for users and readers:
> - use full name VM executable instead of VMX
Why? Searching for "VMware VM executable" in Google provides completely=20
unrelated results.
In contrast, searching for "VMware VMX" provides concrete related results.
We shouldn't rename terminology given by VMware itself to it's own=20
product. It just adds confusion in my opinion.
> - put in official product names in comments instead of enums
I don't see how it provides extra value. Especially due to the fact that=20
the enum constants have their more common product name next to them in=20
comment.
I provide both reference that can be searched in other VMware projects=20
and web and the more user-friendly well-known name.
> - write code using our coding style
Will do. The only coding style violation I see here is the enum type=20
name. Will change from "VMX_Type" to "VMXType".
The rest seems not violating coding convention. Please tell me if I=20
missed something.
> - add a link to where you found a specific number in comments
Good idea. Will add a link to open-vm-tools git repo in vmport.c comment=20
in general.
>
>
>
>
>
>
>>>>>>> Also, how about friendlier string values so people don't need to
>>>>>>> figure out code numbers?
>>>>>> I could have defined a new PropertyInfo struct in hw/core/qdev-pro=
perties.c
>>>>>> for this enum and then define a proper macro in qdev-properties.h.
>>>>>> But it seems like an overkill for a value that is suppose to rarel=
y be
>>>>>> changed. So I thought this should suffice for now for user-experie=
nce
>>>>>> perspective.
>>>>>> If you think otherwise, I can do what I just suggested above.
>>>>>>
>>>>>> -Liran
>>>>> I think that's better, and this allows you to use official
>>>>> product names that people can relate to.
>>>> Ok. Will do...
>>>>> Alternatively just drop this enum completely.  As far as you are
>>>>> concerned it's just a number VM executable gives together with the
>>>>> version, right?  We don't even need the enum, just set it to 2 and =
add a
>>>>> code comment saying it's esx server.
>>>> I could do the latter alternative but why? It just hides information
>>>> original patch author (myself) know about where this value comes fro=
m.
>>>> I don't see a reason to hide information from future code maintainer=
s.
>>>> Similar to defining all flags of a given flag-field even if we use o=
nly a
>>>> subset of it.
>>>>
>>>> -Liran
>>> That belongs in a code comment. Removes need to follow silly names fr=
om
>>> unrelated and possibly incompatible license.
>> What do you mean "unrelated"? It's an official VMware open-source proj=
ect
>> for VMware Tools...
>> I'm only copying definition of constants...
> No you also copy names and comments. Which might make sense in the
> context of the original project but seem to make no sense here.
> E.g. for vmware a given product is deprecated but why does QEMU care?
What is the harm in specifying that? It gives more context.
> enum values are not even listed. What is poor user supposed to do -
> take out a calculator to figure it out?
What do you mean by listed?
>
>>> By comparison dead code is
>>> dead code.
>> Right. That's why I think the enum PropertyInfo mechanism is an overki=
ll at
>> this point.
>>> But sure, if you want to code up user friendly names, that's
>>> ok too. But do follow official names then please, not something lifte=
d
>>> from some piece of code.
>> These are all official names.
> Official as in will stick around, not official as in pushed to
> a github repo.
>
>
>> I'm not sure I understand what you are
>> suggesting.
>>
>> -Liran
> Something like the below.
>
> /*
>   * Most guests are fine with the default.
>   * Some legacy guests hard-code a given type.
>   * See https://urldefense.com/v3/__https://github.com/vmware/open-vm-t=
ools/blob/master/open-vm-tools/lib/include/vm_vmx_type.h__;!!GqivPVa7Brio=
!M9wko4CSBSs3xFA2QY7MIL_jvAxlU5aRZE1jN2hzG5jnk8rdlpYCDs2ymrkJ8GE$
>   * for an up-to-date list of values.
>   *
>   * Reasonable options:
>   * 0 - unset?
>   * 1 - VMware Express (deprecated)
>   * 2 - VMware ESX server
>   * 3 - VMware Workstation
>   * 4 - ACE 1.x (deprecated)
>   */
>
> DEFINE_PROP_UINT8("vm-executable-type", VMPortState, vm_executable_type=
, 2 /* VMware ESX server */),
>
Why is it better to specify a list of all options in a comment than an=20
enum? Isn't enum invented exactly for enumerating all possible values of=20
a field?
Note that even in this simple case, you needed to write "VMware ESX=20
server" twice instead of referring to an enum constant. It doesn't seem=20
more elegant to me.

And again, I disagree with renaming the field to "vm-executable-type"=20
instead of "vmx-type".

-Liran




