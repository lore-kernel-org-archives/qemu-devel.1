Received: from eggs.gnu.org ([2001:4830:134:3::10]:38417)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dNZYM-0003Vv-3N
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:55:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameeh@daynix.com>) id 1dNZYI-0000VJ-50
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:55:50 -0400
Received: from mail-ua0-x241.google.com ([2607:f8b0:400c:c08::241]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sameeh@daynix.com>) id 1dNZYH-0000VC-Oo
	for qemu-devel@nongnu.org; Wed, 21 Jun 2017 02:55:46 -0400
Received: by mail-ua0-x241.google.com with SMTP id z34so14283528uab.0
	for <qemu-devel@nongnu.org>; Tue, 20 Jun 2017 23:55:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKPgXcGw4CnLnmyihQTCObnoLppw1XzrxWcwNE86dwUEXKsQ=Q@mail.gmail.com>
References: <1493299264-10669-1-git-send-email-daniel@daynix.com>
	<1493299264-10669-2-git-send-email-daniel@daynix.com>
	<CAKPgXcHb2TXibijvRQZnYBsyACKmDArvZoEaNBprdkVqqDqsZA@mail.gmail.com>
	<CAKPgXcH=VQ4aeP9X_GR5ZYtzJ2zS3Uru9JhWXJVgTne8nwbdQQ@mail.gmail.com>
	<CAKPgXcGw4CnLnmyihQTCObnoLppw1XzrxWcwNE86dwUEXKsQ=Q@mail.gmail.com>
From: Sameeh Jubran <sameeh@daynix.com>
Date: Wed, 21 Jun 2017 09:55:43 +0300
Message-ID: <CAKPgXcE4LxkpapRTAu+5m-MO2qsFG3-TvfkcECMtk0rFNWT8xg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/1] qga-win: fix installation on
 localized windows
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel Rempel <daniel@daynix.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Dmitry Fleytman <dmitry@daynix.com>, Yan Vugenfirer <yan@daynix.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

This patch have been waiting too long for a review, Can someone please
review it!!

On Thu, Jun 1, 2017 at 3:07 PM, Sameeh Jubran <sameeh@daynix.com> wrote:

> Can someone review this patch please?
>
> On Thu, May 25, 2017 at 2:06 PM, Sameeh Jubran <sameeh@daynix.com> wrote:
>
>> Ping
>>
>> On Sun, May 14, 2017 at 3:53 PM, Sameeh Jubran <sameeh@daynix.com> wrote:
>>
>>> Reviewed-by: Sameeh Jubran <sameeh@daynix.com>
>>>
>>> On Thu, Apr 27, 2017 at 4:21 PM, Daniel Rempel <daniel@daynix.com>
>>> wrote:
>>>
>>>> Bug: https://bugzilla.redhat.com/show_bug.cgi?id=1357789
>>>> Replace hardcoded user and group names ("Administrators", "SYSTEM")
>>>> with the ones acquired from system. Windows uses localized strings for
>>>> these names and it may cause the installation to fail.
>>>> Windows has Well-known SIDs for "Administrators" group and "SYSTEM"
>>>> user so they were used to identify required users and groups.
>>>> Well-known SIDs: https://support.microsoft.com/
>>>> en-us/help/243330/well-known-security-identifiers-in-windows
>>>> -operating-systems
>>>>
>>>> Signed-off-by: Daniel Rempel <daniel@daynix.com>
>>>> ---
>>>>  qga/vss-win32/install.cpp | 35 +++++++++++++++++++++++++++++++++--
>>>>  1 file changed, 33 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/qga/vss-win32/install.cpp b/qga/vss-win32/install.cpp
>>>> index f4160a3..1be482a 100644
>>>> --- a/qga/vss-win32/install.cpp
>>>> +++ b/qga/vss-win32/install.cpp
>>>> @@ -18,6 +18,9 @@
>>>>  #include <wbemidl.h>
>>>>  #include <comdef.h>
>>>>  #include <comutil.h>
>>>> +#include <sddl.h>
>>>> +
>>>> +#define BUFFER_SIZE 1024
>>>>
>>>>  extern HINSTANCE g_hinstDll;
>>>>
>>>> @@ -135,6 +138,27 @@ out:
>>>>      return hr;
>>>>  }
>>>>
>>>> +/* Acquire group or user name by SID */
>>>> +static HRESULT getNameByStringSID(
>>>> +    const wchar_t *sid, LPWSTR buffer, LPDWORD bufferLen)
>>>> +{
>>>> +    HRESULT hr = S_OK;
>>>> +    PSID psid = NULL;
>>>> +    SID_NAME_USE groupType;
>>>> +    DWORD domainNameLen = BUFFER_SIZE;
>>>> +    wchar_t domainName[BUFFER_SIZE];
>>>> +
>>>> +    chk(ConvertStringSidToSidW(sid, &psid));
>>>> +    LookupAccountSidW(NULL, psid, buffer, bufferLen,
>>>> +                domainName, &domainNameLen, &groupType);
>>>> +    hr = HRESULT_FROM_WIN32(GetLastError());
>>>> +
>>>> +    LocalFree(psid);
>>>> +
>>>> +out:
>>>> +    return hr;
>>>> +}
>>>> +
>>>>  /* Find and iterate QGA VSS provider in COM+ Application Catalog */
>>>>  static HRESULT QGAProviderFind(
>>>>      HRESULT (*found)(ICatalogCollection *, int, void *), void *arg)
>>>> @@ -216,6 +240,10 @@ STDAPI COMRegister(void)
>>>>      CHAR dllPath[MAX_PATH], tlbPath[MAX_PATH];
>>>>      bool unregisterOnFailure = false;
>>>>      int count = 0;
>>>> +    DWORD bufferLen = BUFFER_SIZE;
>>>> +    wchar_t buffer[BUFFER_SIZE];
>>>> +    const wchar_t *administratorsGroupSID = L"S-1-5-32-544";
>>>> +    const wchar_t *systemUserSID = L"S-1-5-18";
>>>>
>>>>      if (!g_hinstDll) {
>>>>          errmsg(E_FAIL, "Failed to initialize DLL");
>>>> @@ -284,11 +312,12 @@ STDAPI COMRegister(void)
>>>>
>>>>      /* Setup roles of the applicaion */
>>>>
>>>> +    chk(getNameByStringSID(administratorsGroupSID, buffer,
>>>> &bufferLen));
>>>>      chk(pApps->GetCollection(_bstr_t(L"Roles"), key,
>>>>                               (IDispatch **)pRoles.replace()));
>>>>      chk(pRoles->Populate());
>>>>      chk(pRoles->Add((IDispatch **)pObj.replace()));
>>>> -    chk(put_Value(pObj, L"Name",        L"Administrators"));
>>>> +    chk(put_Value(pObj, L"Name", buffer));
>>>>      chk(put_Value(pObj, L"Description", L"Administrators group"));
>>>>      chk(pRoles->SaveChanges(&n));
>>>>      chk(pObj->get_Key(&key));
>>>> @@ -303,8 +332,10 @@ STDAPI COMRegister(void)
>>>>      chk(GetAdminName(&name));
>>>>      chk(put_Value(pObj, L"User", _bstr_t(".\\") + name));
>>>>
>>>> +    bufferLen = BUFFER_SIZE;
>>>> +    chk(getNameByStringSID(systemUserSID, buffer, &bufferLen));
>>>>      chk(pUsersInRole->Add((IDispatch **)pObj.replace()));
>>>> -    chk(put_Value(pObj, L"User", L"SYSTEM"));
>>>> +    chk(put_Value(pObj, L"User", buffer));
>>>>      chk(pUsersInRole->SaveChanges(&n));
>>>>
>>>>  out:
>>>> --
>>>> 2.9.3
>>>>
>>>>
>>>>
>>>
>>>
>>> --
>>> Respectfully,
>>> *Sameeh Jubran*
>>> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
>>> *Software Engineer @ Daynix <http://www.daynix.com>.*
>>>
>>
>>
>>
>> --
>> Respectfully,
>> *Sameeh Jubran*
>> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
>> *Software Engineer @ Daynix <http://www.daynix.com>.*
>>
>
>
>
> --
> Respectfully,
> *Sameeh Jubran*
> *Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
> *Software Engineer @ Daynix <http://www.daynix.com>.*
>



-- 
Respectfully,
*Sameeh Jubran*
*Linkedin <https://il.linkedin.com/pub/sameeh-jubran/87/747/a8a>*
*Software Engineer @ Daynix <http://www.daynix.com>.*
