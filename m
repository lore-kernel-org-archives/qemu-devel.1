Received: from eggs.gnu.org ([2001:4830:134:3::10]:48891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dOdnI-000684-Vz
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:39:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dOdnE-0001RO-5b
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:39:41 -0400
Received: from m15-114.126.com ([220.181.15.114]:58312)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <indiffpig@126.com>) id 1dOdnC-0001Px-M3
	for qemu-devel@nongnu.org; Sat, 24 Jun 2017 01:39:36 -0400
From: indiffPig@126.com
Date: Sat, 24 Jun 2017 01:39:14 -0400
Message-Id: <1498282754-2573-1-git-send-email-indiffPig@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] qga:windows os lost ip when network nic change
 pic order
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mdroth@linux.vnet.ibm.com
Cc: qemu-devel@nongnu.org, "yin.zuowei" <indiffPig@126.com>

From: "yin.zuowei" <indiffPig@126.com>

Signed-off-by: yin.zuowei <indiffPig@126.com>

bug description: In the windows virtual machine, if there are multiple network cards, the hypothesis is that A/B/C is equipped with a different IP address. Once you delete a B card in the middle and restart the virtual machine, you will find that the A/C of the network card IP has been confused, and the IP of the C network card has become the address of B, and the service has been interrupted. So we did a IP recovery function in qga.This is a serious problem that can lead to business disruption. If you have a better plan, we would like to offer it to you.
---
 qga/restoreIp.cpp | 1848 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 1848 insertions(+)
 create mode 100755 qga/restoreIp.cpp

diff --git a/qga/restoreIp.cpp b/qga/restoreIp.cpp
new file mode 100755
index 0000000..2382136
--- /dev/null
+++ b/qga/restoreIp.cpp
@@ -0,0 +1,1848 @@
+// restoreIp.cpp : 定义控制台应用程序的入口点。
+//#include "stdafx.h"
+#include <tchar.h>
+#include <io.h>
+#include <stdio.h>
+#include <winsock2.h>
+#include <windows.h>
+#include <stdlib.h>
+#include <shellapi.h>
+#include <iphlpapi.h>
+#include <winioctl.h>
+#include <vector> 
+#include <map>
+#include <set>
+
+//#pragma comment(lib,"iphlpapi.lib")
+
+CONST DWORD SUCCESS_CODE = 0;
+CONST DWORD ERROR_CODE = 1;
+CONST DWORD CONFLICT_CODE = 2;
+CONST DWORD NO_IP_CODE = 3;
+CONST DWORD NO_FILE_CODE = 4;
+   
+CONST INT RETRY_TIMES = 3;
+CONST INT SLEEP_TIMES = 2000;
+CONST INT LOG_LEN = 512;
+CONST INT MAX_INI_RECORD = 512;
+
+
+/*要注意，考虑unicode下 memcpy函数，长度要使用XXX_LEN * sizeof(TCHAR)*/
+CONST INT MAC_LEN = 20;
+CONST INT DHCP_LEN = 4;
+CONST INT IP_STR_LEN = 128;
+CONST INT MASK_STR_LEN = 128;
+CONST INT GATE_STR_LEN = 128;
+CONST INT IP_ADDRESS_LEN = 16;
+CONST INT DNS_COUNT = 2; //目前只能有2个DNS地址
+CONST INT DNS_STR_LEN = IP_ADDRESS_LEN * DNS_COUNT; 
+CONST INT ADA_NAME_LEN = 40;
+CONST INT MAX_IP_COUNT = IP_STR_LEN/IP_ADDRESS_LEN;
+
+CONST INT DEL_NIC = -1;
+CONST INT ADD_NIC = 1;
+
+
+/*全局变量一律用 g_开头*/
+TCHAR g_configPath[MAX_PATH];
+BOOL g_VistaOrLater;
+
+CONST INT MAX_PREBUFF_LEN = MAC_LEN*MAX_INI_RECORD;
+TCHAR * g_preMem;
+
+
+/*新增网卡，该键值会发生变化（删除不会发生变化）；启用禁用网卡绝大部分不触发，有时延迟触发；修改IP，有时候也会发生变化，有时又不变化，不太精确*/
+LPCTSTR NIC_CHANGE = _T("SYSTEM\\CurrentControlSet\\Control\\Network\\{4D36E972-E325-11CE-BFC1-08002BE10318}");
+
+/*ip变化该键值就会变化，非常及时*/
+LPCTSTR IP_CHANGE = _T("SYSTEM\\CurrentControlSet\\Services\\Tcpip\\Parameters\\Interfaces\\");
+
+/*准备同时监控上面两个值，但网卡的新增与删除或IP变化，以前后枚举差异为准*/
+
+LPCTSTR DHCP_KEY = _T("dhcp");
+LPCTSTR DHCP_ON = _T("yes");
+LPCTSTR DHCP_OFF = _T("no");
+LPCTSTR IP_KEY = _T("ip");    
+LPCTSTR MASK_KEY = _T("mask");
+LPCTSTR GATEWAY_KEY = _T("gateWay");
+LPCTSTR DNS_KEY = _T("dns");
+LPCTSTR DHCP_IP = _T("169.254");
+
+
+VOID LogEvent(LPCTSTR pFormat, ...)
+{
+    TCHAR  chMsg[LOG_LEN] = {0};
+    HANDLE  hEventSource;
+    LPTSTR  lpszStrings[1];
+    va_list pArg;
+
+    va_start(pArg, pFormat);
+    _vsntprintf(chMsg,LOG_LEN -1 ,pFormat,pArg);
+    va_end(pArg);
+
+    lpszStrings[0] = chMsg;
+
+    hEventSource = RegisterEventSource(NULL, TEXT("QGA"));
+    if (hEventSource != NULL)
+    {
+        ReportEvent(hEventSource, EVENTLOG_INFORMATION_TYPE, 
+            0, 0, NULL, 1, 0, (LPCTSTR*) &lpszStrings[0], NULL);
+        DeregisterEventSource(hEventSource);
+    }
+}
+
+
+
+BOOL FileExist(LPCTSTR pszFileName)
+{
+	BOOL bExist = FALSE;
+	HANDLE hFile;
+
+	if (NULL != pszFileName)
+	{
+		// Use the preferred Win32 API call and not the older OpenFile.
+		hFile = CreateFile(
+			pszFileName,
+			GENERIC_READ,
+			FILE_SHARE_READ | FILE_SHARE_WRITE,
+			NULL,
+			OPEN_EXISTING,
+			0,
+			0);
+
+		if (hFile != INVALID_HANDLE_VALUE)
+		{
+			// If the handle is valid then the file exists.
+			CloseHandle(hFile);
+			bExist = TRUE;
+		}
+	}
+
+	return bExist;
+}
+
+//获取当前系统中的网卡信息
+typedef struct _IP_MASK_INFO
+{
+	TCHAR ip[IP_ADDRESS_LEN];
+	TCHAR mask[IP_ADDRESS_LEN];
+}IP_MASK_INFO;
+
+typedef struct _GATEWAY_INFO
+{
+	TCHAR gateWay[IP_ADDRESS_LEN];
+}GATEWAY_INFO;
+
+
+typedef struct _ADAPTER_INFO
+{
+	TCHAR mac[MAC_LEN];
+	UINT index;
+	TCHAR name[ADA_NAME_LEN];
+	TCHAR dhcpStatus[DHCP_LEN];
+	TCHAR dns[DNS_COUNT][IP_ADDRESS_LEN];
+	std::vector<IP_MASK_INFO>ipMaskVec;
+	std::vector<GATEWAY_INFO>gateWayVec;
+}ADAPTER_INFO, *PADAPTER_INFO;
+
+typedef struct _ADA_DIFF_INFO
+{
+	INT addOrDel;
+	PADAPTER_INFO adaInfo;
+}ADA_DIFF_INFO, *PADA_DIFF_INFO;
+
+VOID charToTchar (const char * _char, TCHAR * tchar)  
+{  
+#ifdef UNICODE
+    INT iLength ; 
+    iLength = MultiByteToWideChar (CP_ACP, 0, _char, strlen (_char) + 1, NULL, 0) ;  
+    MultiByteToWideChar (CP_ACP, 0, _char, strlen (_char) + 1, tchar, iLength) ;  
+#else
+	//这个函数是有危险的
+	strcpy(tchar, _char);
+#endif
+} 
+
+TCHAR* ByteToStr(BYTE *pData, INT nCount, TCHAR* pMac)
+{
+	int i = 0;
+
+	for (i = 0; i < nCount; i++){
+		wsprintf(pMac + _tcslen(pMac), _T("%02X-"),pData[i]);
+	}
+    
+	pMac[_tcslen(pMac) - 1] = '\0';
+	return pMac;
+}
+
+
+/*ip 有可能是相等的，只是多个IP顺序不同，此种情况要调用cmpAdaIpIsEqualWithFile*/
+BOOL cmpStrIsEqual(LPCTSTR srcStr, LPCTSTR dstStr)
+{
+    BOOL ret = TRUE;
+    if (0 != _tcscmp(srcStr, dstStr))
+    {
+        ret = FALSE;
+    }
+    return ret;
+}
+
+/*获取:str:str中字符串中元素的个数*/
+UINT getVauleCountInStr(TCHAR * str)
+{
+	TCHAR *index = NULL;
+	UINT count = 0;
+	index = _tcschr(str, _T(':'));
+
+	//获取str中的元素个数
+	while ((index != NULL))
+	{
+		count++;
+		index = _tcschr(&index[1], _T(':'));
+	}
+	return count;
+}
+
+/*如果在:192.168.25.111中找到192.168.25.11，那么也认为是相同，这是不对的，要对这种情况进行处理
+故该函数是很有必要存在的*/
+BOOL checkIpInStr(TCHAR *ipStr, TCHAR *ip)
+{
+	if(0 == _tcslen(ip))
+		return FALSE;
+
+	TCHAR *index = _tcsstr(ipStr, ip);
+	if(NULL == index)
+		return FALSE;
+
+	if(index[_tcslen(ip)] != _T('\0') && index[_tcslen(ip)] != _T(':'))
+	{
+		return FALSE;
+	}
+
+	return TRUE;
+
+}
+
+
+/*主要是考虑多个IP只是顺序变化，但实际内容没变的情况，ipStrFile是以“:ip1:ip2”的格式进行
+实现的效率可能是个问题，但目前优先保证功能*/
+BOOL cmpAdaIpIsEqualIpStr(ADAPTER_INFO *pAda, TCHAR * ipStr)
+{
+
+	//二者ip的个数不相同，则判断为不同
+	if (pAda->ipMaskVec.size() != getVauleCountInStr(ipStr))
+	{
+		return FALSE;
+	}
+
+	//个数相同前提下，再比较内容，如果内容有一个不一样，就判断为不同
+	if(!pAda->ipMaskVec.empty())
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=pAda->ipMaskVec.begin(); iter!=pAda->ipMaskVec.end(); iter++)
+		{
+			if(!checkIpInStr(ipStr, (*iter).ip))
+				return FALSE;
+		}
+	}
+	return TRUE;
+}
+
+BOOL cmpAdaMaskIsEqualMaskStr(ADAPTER_INFO *pAda, TCHAR * maskStr)
+{
+	//二者mask的个数不相同，则判断为不同
+	if (pAda->ipMaskVec.size() != getVauleCountInStr(maskStr))
+	{
+		return FALSE;
+	}
+
+	//个数相同前提下，再比较内容，如果内容有一个不一样，就判断为不同
+	if(!pAda->ipMaskVec.empty())
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=pAda->ipMaskVec.begin(); iter!=pAda->ipMaskVec.end(); iter++)
+		{
+			if(!checkIpInStr(maskStr, (*iter).mask))
+				return FALSE;
+		}
+	}
+	return TRUE;
+}
+
+BOOL cmpAdaDnsEqualDnsStr(ADAPTER_INFO *pAda, TCHAR * dnsStr)
+{
+	//二者mask的个数不相同，则判断为不同
+	UINT count = 0;
+	for(UINT i = 0; i < DNS_COUNT; i++)
+	{
+		if(_tcslen(pAda->dns[i]) != 0)
+		{
+			count++;
+		}
+
+	}
+
+	if (count != getVauleCountInStr(dnsStr))
+	{
+		return FALSE;
+	}
+
+	//个数相同前提下，再比较内容，如果内容有一个不一样，就判断为不同
+	if(count != 0)
+	{
+		for(UINT i = 0; i < count; i++)
+		{
+			if(_tcslen(pAda->dns[i]) != 0)
+			{
+				if(!checkIpInStr(dnsStr, pAda->dns[i]))
+					return FALSE;
+			}
+		}
+	}
+	return TRUE;
+}
+
+inline BOOL cmpAdaGateWayIsEqualMaskStr(ADAPTER_INFO *pAda, TCHAR * gateWayStr)
+{
+	//二者mask的个数不相同，则判断为不同
+	if (pAda->gateWayVec.size() != getVauleCountInStr(gateWayStr))
+	{
+		return FALSE;
+	}
+
+	//个数相同前提下，再比较内容，如果内容有一个不一样，就判断为不同
+	if(!pAda->gateWayVec.empty())
+	{
+		for(std::vector<GATEWAY_INFO>::iterator iter=pAda->gateWayVec.begin(); iter!=pAda->gateWayVec.end(); iter++)
+		{
+			if(!checkIpInStr(gateWayStr, (*iter).gateWay))
+				return FALSE;
+		}
+	}
+	return TRUE;
+}
+
+BOOL isNullIp(TCHAR * ip)
+{
+	if ((_tcslen(ip) == 0) || cmpStrIsEqual(ip, _T("0.0.0.0")) || (0 == _tcsncmp(ip, DHCP_IP, _tcslen(DHCP_IP))))
+		return TRUE;
+
+	return FALSE;
+}
+
+TCHAR *getMacStrFromAda(PIP_ADAPTER_INFO pAda, TCHAR *macBuff)
+{
+    return ByteToStr(pAda->Address, pAda->AddressLength, &macBuff[0]);
+}
+
+//0 不开启 
+UINT getDhcpStatusFromAda(PIP_ADAPTER_INFO pAda, TCHAR *dhcpBuff)
+{
+    if(dhcpBuff != NULL)
+    {
+        if(0 == pAda->DhcpEnabled)
+        {
+            _tcsncpy(dhcpBuff, DHCP_OFF, DHCP_LEN);
+        }
+        else
+        {
+            _tcsncpy(dhcpBuff, DHCP_ON, DHCP_LEN);
+        }
+            
+    }
+    return pAda->DhcpEnabled;
+}
+
+DWORD readDhcpStatusFromFileByMac(LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR* lpDhcpStatus)
+{
+    return GetPrivateProfileString(lpMac, DHCP_KEY, _T(""), lpDhcpStatus, DHCP_LEN, lpFileName);
+}
+
+VOID writeDhcpStatusToFileByMac(LPCTSTR dpchStatus, LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR *logBuff)
+{
+    WritePrivateProfileString(lpMac, DHCP_KEY, dpchStatus, lpFileName);
+    if(logBuff != NULL)
+    {
+        _tcsncpy(logBuff, dpchStatus, DHCP_LEN);
+    }
+}
+/*
+TCHAR *getIpStrFromAda(PIP_ADAPTER_INFO pAda, TCHAR *ipBuff)
+{
+    IP_ADDR_STRING *pIpAddr = &pAda->IpAddressList;
+	TCHAR tmpStr[IP_ADDRESS_LEN] = {0};
+	INT count = 0;
+    while(NULL != pIpAddr)
+    {
+		charToTchar(pIpAddr->IpAddress.String, tmpStr);
+		if(!isNullIp(tmpStr))
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+			wsprintf(ipBuff + _tcslen(ipBuff), _T(":%s"),tmpStr);
+		}
+        pIpAddr = pIpAddr->Next;
+    }
+    return ipBuff;
+}
+*/
+DWORD readIpStrFromFileByMac(LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR* lpIpStr)
+{
+    return GetPrivateProfileString(lpMac, IP_KEY, _T(""), lpIpStr, IP_STR_LEN, lpFileName);
+}
+
+
+VOID writeIpStrToFileByMac(std::vector<IP_MASK_INFO> &ipMaskVec, LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR *logBuff)
+{
+	TCHAR ipBuff[IP_STR_LEN] = {0};
+	if(ipMaskVec.size() != 0)
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=ipMaskVec.begin(); iter!=ipMaskVec.end(); iter++)
+		{
+			wsprintf(ipBuff + _tcslen(ipBuff), _T(":%s"), (*iter).ip);
+		}
+		WritePrivateProfileString(lpMac, IP_KEY, ipBuff, lpFileName);
+		if(logBuff != NULL)
+		{
+			_tcsncpy(logBuff, ipBuff, IP_STR_LEN);
+		}
+	}
+}
+
+/*
+TCHAR *getMaskStrFromAda(PIP_ADAPTER_INFO pAda, TCHAR *maskBuff)
+{
+    IP_ADDR_STRING *pMaskAddr = &pAda->IpAddressList;
+	TCHAR tmpStr[IP_ADDRESS_LEN] = {0};
+	INT count = 0;
+    while(NULL != pMaskAddr)
+    {
+		charToTchar(pMaskAddr->IpMask.String, tmpStr);
+		if(!isNullIp(tmpStr))
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+			wsprintf(maskBuff + _tcslen(maskBuff), _T(":%s"), tmpStr);
+		}
+        pMaskAddr = pMaskAddr->Next;
+    }
+    return maskBuff;
+}
+*/
+
+DWORD readMaskStrFromFileByMac(LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR* lpMaskStr)
+{
+    return GetPrivateProfileString(lpMac, MASK_KEY, _T(""), lpMaskStr, MASK_STR_LEN, lpFileName);
+}
+
+VOID writeMaskStrToFileByMac(std::vector<IP_MASK_INFO> &ipMaskVec, LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR *logBuff)
+{
+	TCHAR maskBuff[MASK_STR_LEN]={0};
+	if(ipMaskVec.size() != 0)
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=ipMaskVec.begin(); iter!=ipMaskVec.end(); iter++)
+		{
+			wsprintf(maskBuff + _tcslen(maskBuff), _T(":%s"), (*iter).mask);
+		}
+		WritePrivateProfileString(lpMac, MASK_KEY, maskBuff, lpFileName);
+		if(logBuff != NULL)
+		{
+			_tcsncpy(logBuff,maskBuff, MASK_STR_LEN);
+		}
+	}
+}
+/*
+TCHAR *getGateWayStrFromAda(PIP_ADAPTER_INFO pAda, TCHAR *gateWayBuff)
+{
+    IP_ADDR_STRING *pGateWayAddr = &pAda->GatewayList;
+	TCHAR tmpStr[IP_ADDRESS_LEN] = {0};
+	INT count = 0;
+    while(NULL != pGateWayAddr)
+    {
+		charToTchar(pGateWayAddr->IpAddress.String, tmpStr);
+		if(!isNullIp(tmpStr))
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+			wsprintf(gateWayBuff + _tcslen(gateWayBuff), _T(":%s"), tmpStr);
+		}
+        pGateWayAddr = pGateWayAddr->Next;
+    }
+    return gateWayBuff;
+}
+*/
+DWORD readGateWayStrFromFileByMac(LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR* lpGateWayStr)
+{
+    return GetPrivateProfileString(lpMac, GATEWAY_KEY, _T(""), lpGateWayStr, GATE_STR_LEN, lpFileName);
+}
+
+VOID writeGateWayStrToFileByMac(std::vector<GATEWAY_INFO> &gateWayVec, LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR *logBuff)
+{
+	TCHAR gateWayBuff[GATE_STR_LEN] = {0};
+	if(gateWayVec.size() != 0 )
+	{
+		for(std::vector<GATEWAY_INFO>::iterator iter=gateWayVec.begin(); iter!=gateWayVec.end(); iter++)
+		{
+			wsprintf(gateWayBuff + _tcslen(gateWayBuff), _T(":%s"), (*iter).gateWay);
+		}
+		WritePrivateProfileString(lpMac, GATEWAY_KEY, gateWayBuff, lpFileName);
+		if(logBuff != NULL)
+		{
+			_tcsncpy(logBuff,gateWayBuff, GATE_STR_LEN);
+		}
+	}else{
+		/*如果网卡没有GATEWAY，则文件中也要清除GATEWAY选项*/
+		WritePrivateProfileString(lpMac, GATEWAY_KEY, NULL, lpFileName);
+	}
+}
+
+DWORD readDnsStrFromFileByMac(LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR* lpDns)
+{
+	return GetPrivateProfileString(lpMac, DNS_KEY, _T(""), lpDns, DNS_STR_LEN, lpFileName);
+}
+
+/*这里比较纠结，如果是空DSN，则直接清除;而IP呢，如果是空，则不写入；考虑下该如何*/
+VOID writeDnsStrToFileByMac(TCHAR dns[][IP_ADDRESS_LEN], LPCTSTR lpMac, LPCTSTR lpFileName, TCHAR *logBuff)
+{
+	TCHAR dnsBuff[DNS_STR_LEN] = {0};
+
+	if (_tcslen(dns[0]) != 0)
+	{
+		for(int i = 0; i < DNS_COUNT; i++)
+		{
+			if (_tcslen(dns[i]) != 0)
+			{
+				wsprintf(dnsBuff + _tcslen(dnsBuff), _T(":%s"), dns[i]);
+			}
+		}
+		WritePrivateProfileString(lpMac, DNS_KEY, dnsBuff, lpFileName);
+		if(logBuff != NULL)
+		{
+			_tcsncpy(logBuff, dnsBuff, DNS_STR_LEN);
+		}
+	}else{
+		/*如果网卡没有DNS，则文件中也要清除DNS选项*/
+		WritePrivateProfileString(lpMac, DNS_KEY, NULL, lpFileName);
+	}
+
+}
+/*ADAPTER_INFO里面的IP都是合法的，因为之前填入容器时，就已经做了检查*/
+DWORD getIpFromAdaInfo(ADAPTER_INFO * pAdaInfo, TCHAR *ipBuff)
+{
+	INT count = 0;
+	if(pAdaInfo->ipMaskVec.size() != 0)
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=pAdaInfo->ipMaskVec.begin(); iter!=pAdaInfo->ipMaskVec.end(); iter++)
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+				wsprintf(ipBuff + _tcslen(ipBuff), _T(":%s"), (*iter).ip);
+		}
+		return SUCCESS_CODE;
+	}
+	
+	return NO_IP_CODE;
+}
+
+VOID getMaskFromAdaInfo(ADAPTER_INFO * pAdaInfo, TCHAR *maskBuff)
+{
+	INT count = 0;
+	if(pAdaInfo->ipMaskVec.size() != 0)
+	{
+		for(std::vector<IP_MASK_INFO>::iterator iter=pAdaInfo->ipMaskVec.begin(); iter!=pAdaInfo->ipMaskVec.end(); iter++)
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+			wsprintf(maskBuff + _tcslen(maskBuff), _T(":%s"), (*iter).mask);
+		}
+	}
+}
+VOID getGateWayFromAdaInfo(ADAPTER_INFO * pAdaInfo, TCHAR *gateWayBuff)
+{
+	INT count = 0;
+	if(pAdaInfo->gateWayVec.size() != 0)
+	{
+		for(std::vector<GATEWAY_INFO>::iterator iter=pAdaInfo->gateWayVec.begin(); iter!=pAdaInfo->gateWayVec.end(); iter++)
+		{
+			if (++count > MAX_IP_COUNT)
+				break;
+			wsprintf(gateWayBuff + _tcslen(gateWayBuff), _T(":%s"), (*iter).gateWay);
+		}
+	}
+}
+
+VOID getDnsFromAdaInfo(ADAPTER_INFO * pAdaInfo, TCHAR *dnsBuff)
+{
+	if(_tcslen(pAdaInfo->dns[0]) != 0)
+	{
+		for(int i = 0; i < DNS_COUNT; i++)
+		{
+			if (_tcslen(pAdaInfo->dns[i]) != 0)
+			{
+				wsprintf(dnsBuff + _tcslen(dnsBuff), _T(":%s"), pAdaInfo->dns[i]);
+			}
+		}
+
+	}
+}
+
+/*该函数是不可重入的*/
+BOOL isMacExistInFile(LPCTSTR lpMac, LPCTSTR lpFileName)
+{
+	TCHAR *chSectionNames = g_preMem;
+	TCHAR *pSectionName;
+	int i, j = 0; 
+    BOOL ret = FALSE;
+
+	memset(g_preMem, 0, MAX_PREBUFF_LEN*sizeof(TCHAR));
+	GetPrivateProfileSectionNames(chSectionNames, MAX_PREBUFF_LEN, lpFileName);  
+	for(i=0 ;i<MAX_PREBUFF_LEN ;i++,j++)
+	{
+		if(chSectionNames[0]=='\0')
+			break;
+
+		if(chSectionNames[i]=='\0')
+		{
+			pSectionName=&chSectionNames[i-j]; 
+			j = -1;
+
+			if(cmpStrIsEqual(pSectionName, lpMac))
+            {
+                ret = TRUE;
+                break;
+            }
+
+			if(chSectionNames[i+1]==0)
+			{
+				break;
+			}
+		} 
+	}
+    return ret;
+}
+
+VOID freeAdaInfoVec(std::vector<ADAPTER_INFO *> & pAdaInfoVec)
+{
+	if(pAdaInfoVec.size() != 0)
+	{
+		for(std::vector<ADAPTER_INFO *>::iterator iter=pAdaInfoVec.begin(); iter!=pAdaInfoVec.end(); iter++)
+		{
+			delete((*iter));
+		}
+	}
+}
+
+VOID getAdaDnsInfo (ADAPTER_INFO & pAdapter)
+{
+	IP_PER_ADAPTER_INFO* pPerAdapt = NULL;  
+	ULONG ulLen = 0;  
+	int err = GetPerAdapterInfo( pAdapter.index, pPerAdapt, &ulLen);  
+	if( err == ERROR_BUFFER_OVERFLOW )  
+	{  
+		pPerAdapt = (IP_PER_ADAPTER_INFO*) malloc(ulLen);  
+		err = GetPerAdapterInfo( pAdapter.index, pPerAdapt, &ulLen );  
+		if( err == ERROR_SUCCESS )  
+		{  
+			IP_ADDR_STRING* pNext = &( pPerAdapt->DnsServerList );  
+			TCHAR tmpIp[IP_ADDRESS_LEN] = {0};
+
+			if (NULL != pNext)//自动获取为false 
+			{  
+				charToTchar(pNext->IpAddress.String, tmpIp);
+
+				if(!isNullIp(tmpIp))
+				{
+					memcpy(pAdapter.dns[0], tmpIp, sizeof(tmpIp));
+                                        pNext=pNext->Next;
+					if (NULL != pNext)  
+					{  
+						memset(tmpIp, 0, sizeof(tmpIp));
+						charToTchar(pNext->IpAddress.String, tmpIp);
+						if(!isNullIp(tmpIp))
+							memcpy(pAdapter.dns[1], tmpIp, sizeof(tmpIp));
+					}  
+				}
+			}  
+		}  
+	}
+
+	if(pPerAdapt)
+		free(pPerAdapt);
+}
+
+DWORD GetNicInfo(std::vector<ADAPTER_INFO *> & ppAdaInfo)
+{
+	PIP_ADAPTER_INFO pAdapterInfo;
+    PIP_ADAPTER_INFO pAdapter = NULL;
+    DWORD dwRetVal = 0;
+	ADAPTER_INFO *tmpAdaInfo = NULL;
+
+    ULONG ulOutBufLen = sizeof (IP_ADAPTER_INFO);
+    pAdapterInfo = (IP_ADAPTER_INFO *) malloc(sizeof (IP_ADAPTER_INFO));
+    if (pAdapterInfo == NULL) {
+		LogEvent(_T("[QGA]Error allocating memory needed to call GetAdaptersinfo"));
+        return ERROR_NOT_ENOUGH_MEMORY;
+    }
+
+    if (GetAdaptersInfo(pAdapterInfo, &ulOutBufLen) == ERROR_BUFFER_OVERFLOW) {
+        free(pAdapterInfo);
+        pAdapterInfo = (IP_ADAPTER_INFO *) malloc(ulOutBufLen);
+        if (pAdapterInfo == NULL) {
+			LogEvent(_T("[QGA]Error allocating pAdapterInfo needed to call GetAdaptersinfo"));
+            return ERROR_NOT_ENOUGH_MEMORY;
+        }
+    }
+
+    if ((dwRetVal = GetAdaptersInfo(pAdapterInfo, &ulOutBufLen)) == NO_ERROR) {
+        pAdapter = pAdapterInfo;
+        while (pAdapter) {
+
+            if (pAdapter->Type != MIB_IF_TYPE_ETHERNET) {
+				pAdapter = pAdapter->Next;
+				continue;
+			}
+
+			tmpAdaInfo = new ADAPTER_INFO();
+			 if (tmpAdaInfo == NULL) {
+			LogEvent(_T("[QGA]Error allocating tmpAdaInfo needed to call GetAdaptersinfo"));
+            return ERROR_NOT_ENOUGH_MEMORY;
+
+			}
+
+			memset(tmpAdaInfo->mac, 0, sizeof(tmpAdaInfo->mac));
+			tmpAdaInfo->index = 0;
+			memset(tmpAdaInfo->dhcpStatus, 0, sizeof(tmpAdaInfo->dhcpStatus));
+			getMacStrFromAda(pAdapter, tmpAdaInfo->mac);
+			getDhcpStatusFromAda(pAdapter, tmpAdaInfo->dhcpStatus);
+			tmpAdaInfo->index = pAdapter->Index;
+			charToTchar(pAdapter->AdapterName, tmpAdaInfo->name);
+
+			memset(tmpAdaInfo->dns[0], 0, sizeof(tmpAdaInfo->dns[0]));
+			memset(tmpAdaInfo->dns[1], 0, sizeof(tmpAdaInfo->dns[1]));
+
+			//获取IP MASK GATEWAY
+			IP_ADDR_STRING *pIpAddr = &pAdapter->IpAddressList;
+			IP_MASK_INFO tmpIpMask; 
+			while(NULL != pIpAddr)
+			{
+				memset(tmpIpMask.ip, 0, sizeof(tmpIpMask.ip));
+				memset(tmpIpMask.mask, 0, sizeof(tmpIpMask.mask));
+				charToTchar(pIpAddr->IpAddress.String, tmpIpMask.ip);
+				charToTchar(pIpAddr->IpMask.String, tmpIpMask.mask);
+				if(!isNullIp(tmpIpMask.ip) && !isNullIp(tmpIpMask.mask))
+				{
+					(tmpAdaInfo->ipMaskVec).push_back(tmpIpMask);
+				}
+				pIpAddr = pIpAddr->Next;
+			}
+
+			IP_ADDR_STRING *pGateWayAddr = &pAdapter->GatewayList;
+			GATEWAY_INFO tmpGateWay; 
+			while(NULL != pGateWayAddr)
+			{
+				memset(tmpGateWay.gateWay, 0, sizeof(tmpGateWay.gateWay));
+				charToTchar(pGateWayAddr->IpAddress.String, tmpGateWay.gateWay);
+				if(!isNullIp(tmpGateWay.gateWay))
+				{
+					(*tmpAdaInfo).gateWayVec.push_back(tmpGateWay);
+				}
+				pGateWayAddr = pGateWayAddr->Next;
+			}
+
+			//dns
+			getAdaDnsInfo((*tmpAdaInfo));
+
+			ppAdaInfo.push_back(tmpAdaInfo);
+			pAdapter = pAdapter->Next;
+        }
+    } else {
+		if(ERROR_NO_DATA != dwRetVal)
+			LogEvent(_T("GetAdaptersInfo failed with error: %d\n"), dwRetVal);
+    }
+    if (pAdapterInfo)
+        free(pAdapterInfo);
+
+    return ERROR_SUCCESS;
+}
+
+BOOL cmpDnsInfoIsEqualWithFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	TCHAR dnsFileBuff[DNS_STR_LEN] = {0};
+
+	readDnsStrFromFileByMac(pAdaInfo->mac, pIniPath, dnsFileBuff);
+	if(!cmpAdaDnsEqualDnsStr(pAdaInfo, dnsFileBuff))
+		return FALSE;
+
+	return TRUE;
+
+}
+BOOL cmpIpInfoIsEqualWithFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	TCHAR ipFileBuff[IP_STR_LEN] = {0};
+	TCHAR maskFileBuff[MASK_STR_LEN] = {0};
+	TCHAR gateWayFileBuff[GATE_STR_LEN] = {0};
+
+	
+	readIpStrFromFileByMac(pAdaInfo->mac, pIniPath, ipFileBuff);
+	if(!cmpAdaIpIsEqualIpStr(pAdaInfo, ipFileBuff))
+		return FALSE;
+
+	readMaskStrFromFileByMac(pAdaInfo->mac, pIniPath, maskFileBuff);
+	if(!cmpAdaMaskIsEqualMaskStr(pAdaInfo, maskFileBuff))
+		return FALSE;
+
+	readGateWayStrFromFileByMac(pAdaInfo->mac, pIniPath, gateWayFileBuff);
+	if(!cmpAdaGateWayIsEqualMaskStr(pAdaInfo, gateWayFileBuff))
+		return FALSE;
+
+	return TRUE;
+
+}
+//保存一块网卡信息的函数
+VOID saveAdaIpToFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+    TCHAR logDhcpBuff[DHCP_LEN] = {0};
+    TCHAR logIpBuff[IP_STR_LEN] = {0};
+    TCHAR logMaskBuff[MASK_STR_LEN] = {0};
+    TCHAR logGateWayBuff[GATE_STR_LEN] = {0};
+
+    writeDhcpStatusToFileByMac(pAdaInfo->dhcpStatus, pAdaInfo->mac, pIniPath, logDhcpBuff);
+
+	//如果是通过DHCP的方式获取的IP，则只保存DHCP信息到ini文件
+	if(cmpStrIsEqual(pAdaInfo->dhcpStatus, DHCP_ON))
+	{
+		LogEvent(_T("[QGA]save mac:%s dhcp:%s  to file"), pAdaInfo->mac, logDhcpBuff);
+		return;
+	}
+    writeIpStrToFileByMac(pAdaInfo->ipMaskVec, pAdaInfo->mac, pIniPath, logIpBuff);
+    writeMaskStrToFileByMac(pAdaInfo->ipMaskVec, pAdaInfo->mac, pIniPath, logMaskBuff);
+    writeGateWayStrToFileByMac(pAdaInfo->gateWayVec, pAdaInfo->mac, pIniPath, logGateWayBuff);
+
+    LogEvent(_T("[QGA]save mac:%s dhcp:%s ip:%s mask %s gateway %s to file"), pAdaInfo->mac, logDhcpBuff, logIpBuff, logMaskBuff, logGateWayBuff);
+    
+}
+
+//保存一块网卡DNS信息的函数
+VOID saveAdaDnsToFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+
+	TCHAR logDnsBuff[DNS_STR_LEN] = {0};
+
+	if(!cmpDnsInfoIsEqualWithFile(pAdaInfo, pIniPath))
+		writeDnsStrToFileByMac(pAdaInfo->dns, pAdaInfo->mac, pIniPath, logDnsBuff);
+
+	LogEvent(_T("[QGA]save mac:%s dns:%s to file"), pAdaInfo->mac, logDnsBuff);
+
+}
+VOID saveAdaIpDnsToFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	saveAdaIpToFile(pAdaInfo, pIniPath);
+	saveAdaDnsToFile(pAdaInfo, pIniPath);
+}
+//保存网卡MAC和IP DNS信息到config.ini
+VOID saveNicInfo(std::vector<ADAPTER_INFO  *> &pNicInfoVec, TCHAR *pIniPath)
+{
+	LogEvent(_T("[QGA]save nic config info start."));
+	if(pNicInfoVec.size() != 0)
+	{
+		for(std::vector<ADAPTER_INFO *>::iterator iter=pNicInfoVec.begin(); iter!=pNicInfoVec.end(); iter++)
+		{
+			 saveAdaIpDnsToFile((*iter), pIniPath);
+		}
+	}
+	LogEvent(_T("[QGA]save nic config info end."));
+}
+
+VOID setAdaIpFromDhcp(ADAPTER_INFO * pAdaInfo)
+{
+	TCHAR cmd[MAX_PATH] = {0};
+
+	if(g_VistaOrLater)
+	{
+		wsprintf(cmd, _T("netsh interface ip set address name=\"%d\" source=dhcp"), pAdaInfo->index);
+	}
+	else
+	{
+		wsprintf(cmd, _T("netsh interface ip set address name=\"%s\" source=dhcp"), pAdaInfo->name);
+	}
+    _tsystem(cmd);
+	LogEvent(_T("[QGA] exec mac %s cmd %s"), pAdaInfo->mac, cmd);
+}
+
+VOID setAdaDnsFromDhcp(ADAPTER_INFO * pAdaInfo)
+{
+	TCHAR cmd[MAX_PATH] = {0};
+
+	if(g_VistaOrLater)
+	{
+		wsprintf(cmd, _T("netsh interface ip set dns name=\"%d\" source=dhcp"), pAdaInfo->index);
+	}
+	else
+	{
+		wsprintf(cmd, _T("netsh interface ip set dns name=\"%s\" source=dhcp"), pAdaInfo->name);
+	}
+	_tsystem(cmd);
+	LogEvent(_T("[QGA] exec mac %s cmd %s"), pAdaInfo->mac, cmd);
+}
+
+VOID setAdaIpDnsFromDhcpSyncFile(ADAPTER_INFO * pAdaInfo)
+{
+	setAdaIpFromDhcp(pAdaInfo);
+	//删除后，直接保存DHCP的格式到文件
+	writeDhcpStatusToFileByMac(DHCP_ON, pAdaInfo->mac, g_configPath, NULL);
+
+	setAdaDnsFromDhcp(pAdaInfo);
+	writeDnsStrToFileByMac(pAdaInfo->dns, pAdaInfo->mac, g_configPath, NULL);
+
+
+}
+VOID createDnsCmd(ADAPTER_INFO * pAdaInfo, LPCTSTR dns, BOOL first, TCHAR *cmd)
+{
+	if(g_VistaOrLater)
+	{
+		wsprintf(cmd,
+			_T("netsh interface ip %s dns name=\"%d\" %s %s=%s %s"),
+			first ? _T("set") : _T("add"),
+			pAdaInfo->index,
+			first ? _T("source=static") : _T(""),
+			g_VistaOrLater ? _T("address") : _T("addr"),
+			dns,
+			g_VistaOrLater ? _T("validate = no") : _T(""));
+	}
+	else //only for xp
+	{
+		wsprintf(cmd,
+			_T("netsh interface ip %s dns name=\"%s\" %s %s=%s %s"),
+			first ? _T("set") : _T("add"),
+			pAdaInfo->name,
+			first ? _T("source=static") : _T(""),
+			g_VistaOrLater ? _T("address") : _T("addr"),
+			dns,
+			g_VistaOrLater ? _T("validate = no") : _T(""));
+	}
+	LogEvent(_T("[QGA] exec mac %s cmd %s"), pAdaInfo->mac, cmd);
+}
+VOID setAdaDnsFromStr(ADAPTER_INFO * pAdaInfo, TCHAR *dnsBuff)
+{
+	TCHAR *dns = NULL;
+	TCHAR *dnsNext = NULL;
+	BOOL first = TRUE;
+	TCHAR cmd[MAX_PATH];
+
+
+	dns = _tcschr(dnsBuff, _T(':'));
+
+	while ((dns != NULL))
+	{
+		dnsNext = _tcschr(&dns[1], _T(':'));
+		if(dnsNext) 
+			*dnsNext = 0;
+		createDnsCmd(pAdaInfo, &dns[1], first, cmd);
+		_tsystem(cmd);
+		first = FALSE;
+		dns = dnsNext;
+	}
+}
+/*设置网卡的DNS*/
+VOID setAdaDnsFromFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	TCHAR dnsFileBuff[DNS_STR_LEN] = {0};
+	
+	readDnsStrFromFileByMac(pAdaInfo->mac, pIniPath, dnsFileBuff);
+
+	//如果带恢复的是空dns，直接从dhcp获取dns后退出
+	if(isNullIp(dnsFileBuff))
+	{
+		LogEvent(_T("[QGA]restore dns in file is null, set MAC %s dns form dhcp."), pAdaInfo->mac);
+		setAdaDnsFromDhcp(pAdaInfo);
+		return;
+	}
+	else 
+	{
+		//比较的DNS是否相等的工作不能放在这里面，要放在外面
+		LogEvent(_T("[QGA]set MAC %s dns %s ."), pAdaInfo->mac, dnsFileBuff);
+		setAdaDnsFromStr(pAdaInfo, dnsFileBuff);
+	}
+}
+
+VOID setOSversion(VOID)
+{
+    OSVERSIONINFO osvi;
+	ZeroMemory(&osvi, sizeof(OSVERSIONINFO));
+	osvi.dwOSVersionInfoSize = sizeof(OSVERSIONINFO);
+	GetVersionEx(&osvi);
+	g_VistaOrLater = (osvi.dwMajorVersion >= 6);
+}
+
+//区分了XP，故要测试XP
+VOID createIpCmd(ADAPTER_INFO * pAdaInfo, LPCTSTR ip, LPCTSTR mask, BOOL first, TCHAR *cmd)
+{
+	if(g_VistaOrLater)
+	{
+		wsprintf(cmd,
+			_T("netsh interface ip %s address name=\"%d\" %s %s=%s mask=%s"),
+			first ? _T("set") : _T("add"),
+			pAdaInfo->index,
+			first ? _T("source=static") : _T(""),
+			g_VistaOrLater ? _T("address") : _T("addr"),
+			ip,
+			mask);
+	}
+	else //only for xp
+	{
+		wsprintf(cmd,
+			_T("netsh interface ip %s address name=\"%s\" %s %s=%s mask=%s"),
+			first ? _T("set") : _T("add"),
+			pAdaInfo->name,
+			first ? _T("source=static") : _T(""),
+			g_VistaOrLater ? _T("address") : _T("addr"),
+			ip,
+			mask);
+	}
+	LogEvent(_T("[QGA] exec mac %s cmd %s"), pAdaInfo->mac, cmd);
+}
+//gwmetric==0是表示网卡在同一网段，这里其实是不严谨的
+VOID createGateWayCmd(ADAPTER_INFO * pAdaInfo, LPCTSTR gateWay, TCHAR *cmd)
+{
+	if(g_VistaOrLater)
+	{
+		wsprintf(cmd,
+				_T("netsh interface ip add address name=\"%d\" gateway=%s gwmetric=0"),
+				pAdaInfo->index,
+				gateWay);
+	}
+	else
+	{
+		wsprintf(cmd,
+				_T("netsh interface ip add address name=\"%s\" gateway=%s gwmetric=0"),
+				pAdaInfo->name,
+				gateWay);
+	}
+}
+
+//该函数的不规范在于:修改了入参变量的值
+VOID setAdaIpFromStr(ADAPTER_INFO * pAdaInfo, TCHAR * ipBuff, TCHAR * maskBuff, TCHAR * gateWay)
+{
+    TCHAR *ip = NULL;
+    TCHAR *mask = NULL;
+    TCHAR *gate = NULL;
+
+	TCHAR *ipNext = NULL;
+    TCHAR *maskNext = NULL;
+    TCHAR *gateNext = NULL;
+
+    BOOL first = TRUE;
+    TCHAR cmd[MAX_PATH];
+    
+    ip = _tcschr(ipBuff, _T(':'));
+    mask = _tcschr(maskBuff, _T(':'));
+    gate = _tcschr(gateWay, _T(':'));
+    
+    while ((ip != NULL) && (mask != NULL))
+    {
+		ipNext = _tcschr(&ip[1], _T(':'));
+		if(ipNext) 
+			*ipNext = 0;
+		maskNext = _tcschr(&mask[1], _T(':'));
+		if(maskNext) 
+			*maskNext = 0;
+
+        createIpCmd(pAdaInfo, &ip[1], &mask[1] , first, cmd);
+        _tsystem(cmd);
+        first = FALSE;
+       
+		ip = ipNext;
+		mask = maskNext;
+    }
+
+    
+    while ((gate != NULL))
+    {
+		gateNext = _tcschr(&gate[1], _T(':'));
+		if(gateNext) 
+			*gateNext = 0;
+
+        createGateWayCmd(pAdaInfo, &gate[1], cmd);
+        _tsystem(cmd);
+        
+		gate = gateNext;
+    }
+}
+
+VOID setAdaIpFromFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+    TCHAR dhcpBuff[DHCP_LEN] = {0};
+    TCHAR ipBuff[IP_STR_LEN] = {0};
+    TCHAR maskBuff[MASK_STR_LEN] = {0};
+    TCHAR gateWay[GATE_STR_LEN] = {0};
+
+    readDhcpStatusFromFileByMac(pAdaInfo->mac, pIniPath, dhcpBuff);
+
+    //如果是开启DHCP方式，则从DHCP方式获取IP
+    if(cmpStrIsEqual(dhcpBuff, DHCP_ON))
+    {
+        LogEvent(_T("[QGA]set MAC %s ip form dhcp."), pAdaInfo->mac);
+		setAdaIpFromDhcp(pAdaInfo);
+        return;    
+    }
+
+    //从配置文件中读取IP MASK GATEWAY后，进行设置
+    readIpStrFromFileByMac(pAdaInfo->mac, pIniPath, ipBuff);
+    
+	/*如果待恢复的IP是空IP，则直接从DHCP获取一个169的IP后退出*/
+	if(isNullIp(ipBuff))
+	{
+		LogEvent(_T("[QGA]restore ip in file is null, set MAC %s ip form dhcp."), pAdaInfo->mac);
+		setAdaIpFromDhcp(pAdaInfo);
+		writeDhcpStatusToFileByMac(DHCP_ON, pAdaInfo->mac, pIniPath, NULL);
+	}
+	else
+	{
+		readMaskStrFromFileByMac(pAdaInfo->mac, pIniPath, maskBuff);
+		readGateWayStrFromFileByMac(pAdaInfo->mac, pIniPath, gateWay);
+		LogEvent(_T("[QGA]set MAC %s ip %s netmask %s gateway %s."), pAdaInfo->mac, ipBuff, maskBuff, gateWay);
+		setAdaIpFromStr(pAdaInfo, ipBuff, maskBuff, gateWay);
+	}
+    
+}
+
+//冲突是检测什么：检测待要恢复的IP串，是否已经存在于其他网卡之上
+BOOL checkIpConflict(ADAPTER_INFO * pAdaInfo, TCHAR *ipStr)
+{
+
+    DWORD dwRet;
+	std::vector<ADAPTER_INFO *> pAdaInfoVect;
+    
+	if(isNullIp(ipStr))
+		return FALSE;
+
+    //重新获取当前网卡所有的IP地址
+    if ((dwRet = GetNicInfo(pAdaInfoVect)) != ERROR_SUCCESS)
+    {
+        LogEvent(_T("[QGA]cannot get nic info."));
+        return dwRet;
+    }
+
+	if(pAdaInfoVect.size() != 0)
+	{
+		for(std::vector<ADAPTER_INFO*>::iterator iter=pAdaInfoVect.begin(); iter!=pAdaInfoVect.end(); iter++)
+		{
+			//跳过自己，只比较其他网卡
+			if((*iter)->index == pAdaInfo->index)
+				continue;
+
+			if((*iter)->ipMaskVec.size() != 0)
+			{
+				for(std::vector<IP_MASK_INFO>::iterator iter1=(*iter)->ipMaskVec.begin(); iter1!=(*iter)->ipMaskVec.end(); iter1++)
+				{
+					if(checkIpInStr(ipStr, (*iter1).ip))
+					{
+						LogEvent(_T("[QGA] mac %s want restore or inherit ip %s , but conflict with mac %s "), pAdaInfo->mac, ipStr, (*iter)->mac);
+						freeAdaInfoVec(pAdaInfoVect);
+						return TRUE;
+					}
+				}
+			}
+		}
+	}
+	freeAdaInfoVec(pAdaInfoVect);
+    return FALSE;
+}
+DWORD updateAdaFromFile(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+    TCHAR ipFileBuff[IP_STR_LEN] = {0};
+	TCHAR dhcpFileBuff[DHCP_LEN] = {0};
+    DWORD ret = SUCCESS_CODE;
+
+	do{
+	readDhcpStatusFromFileByMac(pAdaInfo->mac, pIniPath, dhcpFileBuff);
+
+	//如果都是从DHCP获取的IP，则不需要恢复IP
+		if(cmpStrIsEqual(pAdaInfo->dhcpStatus, DHCP_ON) && cmpStrIsEqual(dhcpFileBuff, DHCP_ON)){
+			//如果DNS不相等，则设置DNS后退出
+			if(!cmpDnsInfoIsEqualWithFile(pAdaInfo, pIniPath))
+				setAdaDnsFromFile(pAdaInfo, pIniPath);
+			break;
+       }
+
+	readIpStrFromFileByMac(pAdaInfo->mac, pIniPath, ipFileBuff);
+
+    //ip 不相等则做恢复动作。
+		if(!cmpIpInfoIsEqualWithFile(pAdaInfo,pIniPath)){
+			if(!checkIpConflict(pAdaInfo, ipFileBuff)){
+            setAdaIpFromFile(pAdaInfo, pIniPath);
+			}else{
+            ret = CONFLICT_CODE;
+				break;
+        }
+    }
+
+		//dns不相等则做DNS恢复动作
+		if(!cmpDnsInfoIsEqualWithFile(pAdaInfo, pIniPath))
+			setAdaDnsFromFile(pAdaInfo, pIniPath);
+	}while(0);
+
+    return ret;
+}
+
+DWORD updateNicInfo(std::vector<ADAPTER_INFO  *> &pNicInfoVec, TCHAR *pIniPath)
+{	
+    TCHAR ipFileBuff[IP_STR_LEN] = { 0 };
+    std::vector<ADAPTER_INFO *> infoList; 
+    DWORD ret = SUCCESS_CODE;
+
+	if(pNicInfoVec.size() != 0)
+	{
+		for(std::vector<ADAPTER_INFO *>::iterator iter=pNicInfoVec.begin(); iter!=pNicInfoVec.end(); iter++)
+		{
+			if(isMacExistInFile((*iter)->mac, pIniPath))
+			{
+				//IP冲突
+				if(CONFLICT_CODE == updateAdaFromFile(*iter, pIniPath))
+				{
+					setAdaIpFromDhcp((*iter));
+					infoList.push_back(*iter);
+					LogEvent(_T("[QGA] mac %s restore ip conflict, insert to list"),(*iter)->mac);
+					continue;
+				}
+			}
+			else
+			{
+				saveAdaIpDnsToFile(*iter, pIniPath);
+			}
+		}
+	
+		if(infoList.size() != 0)
+		{
+			//如还发生冲突，就是系统本来IP就存在冲突，报错或退出，不是恢复IP功能的问题
+			for(std::vector<ADAPTER_INFO *>::iterator iter=infoList.begin(); iter!=infoList.end(); iter++)
+			{
+				readIpStrFromFileByMac((*iter)->mac, pIniPath, ipFileBuff);
+				if(!checkIpConflict((*iter), ipFileBuff))
+				{
+					setAdaIpFromFile((*iter), pIniPath);
+					//dns不相等则做DNS恢复动作
+					if(!cmpDnsInfoIsEqualWithFile((*iter), pIniPath))
+						setAdaDnsFromFile((*iter), pIniPath);
+				}
+				else
+				{
+					ret = CONFLICT_CODE;
+					LogEvent(_T("[QGA] mac %s can not restore ip, because conflict"),(*iter)->mac);
+				}
+			}
+		}
+	}
+
+    return ret;
+}
+
+
+DWORD restoreNicIp(std::vector<ADAPTER_INFO  *> &pAdaInfoVect)
+{
+    DWORD ret = SUCCESS_CODE;
+
+    if (FileExist(g_configPath))
+    {
+        ret = updateNicInfo(pAdaInfoVect, g_configPath);
+    }
+    else
+    {
+        saveNicInfo(pAdaInfoVect, g_configPath);
+		ret = NO_FILE_CODE;
+    }
+
+    return ret ;
+
+}
+/*检查IP恢复是否成功*/
+DWORD checkRestoreNicIpResult(VOID)
+{
+	DWORD ret = SUCCESS_CODE;
+
+	TCHAR ipFileBuff[IP_STR_LEN] = {0};
+	TCHAR ipAdaBuff[IP_STR_LEN] = {0};
+	TCHAR dhcpFileBuff[DHCP_LEN] = {0};
+	DWORD dwRet;
+
+	std::vector<ADAPTER_INFO  *> pAdaInfoVect;
+
+	if ((dwRet = GetNicInfo(pAdaInfoVect)) != ERROR_SUCCESS)
+	{
+		LogEvent(_T("[QGA]cannot get nic info."));
+		return dwRet;
+	}
+
+	for(std::vector<ADAPTER_INFO *>::iterator iter=pAdaInfoVect.begin(); iter!=pAdaInfoVect.end(); iter++)
+	{
+		if(isMacExistInFile((*iter)->mac, g_configPath))
+		{
+			memset(dhcpFileBuff, 0, sizeof(dhcpFileBuff));
+			readDhcpStatusFromFileByMac((*iter)->mac, g_configPath, dhcpFileBuff);
+			//如果都已经是从DHCP获取的IP，则说明恢复成功。
+			if(cmpStrIsEqual((*iter)->dhcpStatus, DHCP_ON) && cmpStrIsEqual(dhcpFileBuff, DHCP_ON))
+			{
+				//dns不相等则做DNS恢复动作
+				if(!cmpDnsInfoIsEqualWithFile((*iter), g_configPath))
+					setAdaDnsFromFile((*iter), g_configPath);
+				continue;
+			}
+
+			//如果文件是从DHCP获取，但是实际缺不是从DHCP,说明没有成功，重新从DHCP恢复一次IP
+			if(cmpStrIsEqual((*iter)->dhcpStatus, DHCP_OFF) && cmpStrIsEqual(dhcpFileBuff, DHCP_ON))
+			{
+				LogEvent(_T("[QGA] mac %s ip not from dhcp ,but file is from dhcp, restore ip from dhcp"), (*iter)->mac);
+				setAdaIpFromDhcp(*iter);
+				//dns不相等则做DNS恢复动作
+				if(!cmpDnsInfoIsEqualWithFile((*iter), g_configPath))
+					setAdaDnsFromFile((*iter), g_configPath);
+				ret = ERROR_CODE;
+				continue;
+			}
+
+			//如果文件是非DHCP，实际的IP却是DHCP,则尝试恢复一次
+			if(cmpStrIsEqual((*iter)->dhcpStatus, DHCP_ON) && cmpStrIsEqual(dhcpFileBuff, DHCP_OFF))
+			{
+				LogEvent(_T("[QGA] mac %s ip from dhcp ,but file is not from dhcp, restore ip from file"), (*iter)->mac);
+				setAdaIpFromFile(*iter, g_configPath);
+				//dns不相等则做DNS恢复动作
+				if(!cmpDnsInfoIsEqualWithFile((*iter), g_configPath))
+					setAdaDnsFromFile((*iter), g_configPath);
+				ret = ERROR_CODE;
+				continue;
+			}
+
+			//如果文件是非DHCP，实际的IP也是非DHCP,但是IP对不上，则尝试恢复一次
+			if(cmpStrIsEqual((*iter)->dhcpStatus, DHCP_OFF) && cmpStrIsEqual(dhcpFileBuff, DHCP_OFF))
+			{
+				memset(ipFileBuff, 0, sizeof(ipFileBuff));
+				readIpStrFromFileByMac((*iter)->mac, g_configPath, ipFileBuff);
+				
+				if(!cmpAdaIpIsEqualIpStr((*iter), ipFileBuff))
+				{
+					memset(ipAdaBuff, 0, sizeof(ipAdaBuff));
+					getIpFromAdaInfo(*iter, ipAdaBuff);
+					LogEvent(_T("[QGA] mac %s ip %s is not same as file %s, so restore ip from file"), (*iter)->mac, ipAdaBuff, ipFileBuff);
+					setAdaIpFromFile(*iter, g_configPath);
+					ret = ERROR_CODE;
+				}
+
+				//dns不相等则做DNS恢复动作
+				if(!cmpDnsInfoIsEqualWithFile((*iter), g_configPath))
+					setAdaDnsFromFile((*iter), g_configPath);
+
+				continue;
+			}
+
+		}
+	}
+	freeAdaInfoVec(pAdaInfoVect);
+	return ret ;
+}
+
+VOID delRecordByMac(LPCTSTR lpMac, TCHAR *pIniPath)
+{
+	WritePrivateProfileString(lpMac, NULL, NULL, pIniPath);
+}
+
+/*使用了全局变量，该函数是不可重入的:这个函数是在干什么 ？当前网卡设置的IP，是否与文件中已经存在的
+IP冲突，如果冲突，我们认为文件中的IP是多余的，就要清楚记录文件中的对应记录。但要主要，不要与自己的
+MAC地址比较，即要跳过自己，不认为自己与自己冲突*/
+VOID clearConflictIpInConfig(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	/*该函数是不可重入的，另外一个函数也使用了g_preMem，二者也不能同时使用*/
+	TCHAR *chSectionNames = g_preMem;
+	TCHAR *pSectionName;
+	TCHAR ipStr[IP_STR_LEN] = {0};
+	int i, j = 0; 
+
+	memset(g_preMem, 0, MAX_PREBUFF_LEN*sizeof(TCHAR));
+	GetPrivateProfileSectionNames(chSectionNames, MAX_PREBUFF_LEN, pIniPath);  
+	for(i=0 ;i<MAX_PREBUFF_LEN ;i++,j++)
+	{
+		if(chSectionNames[0]=='\0')
+			break;
+
+		if(chSectionNames[i]=='\0')
+		{
+			pSectionName=&chSectionNames[i-j]; 
+			j = -1;
+
+			//跳过自己
+			if(cmpStrIsEqual(pSectionName, pAdaInfo->mac))
+			{
+				continue;
+			}
+
+			memset(ipStr, 0, sizeof(ipStr));
+			readIpStrFromFileByMac(pSectionName, pIniPath, ipStr);
+
+			if(!isNullIp(ipStr))
+			{
+				if((pAdaInfo)->ipMaskVec.size() != 0)
+				{
+					for(std::vector<IP_MASK_INFO>::iterator iter=pAdaInfo->ipMaskVec.begin(); iter!=pAdaInfo->ipMaskVec.end(); iter++)
+					{
+						if(!isNullIp((*iter).ip) && checkIpInStr(ipStr, (*iter).ip))
+						{
+							LogEvent(_T("[QGA] clear mac %s ip %s in ini-file, ip %s already at mac %s"), pSectionName, ipStr, (*iter).ip, pAdaInfo->mac);
+							WritePrivateProfileString(pSectionName, NULL, NULL, pIniPath);
+							/*找到一个就退出了，这里是不是要继续找，先这样处理*/
+							return;
+						}
+					}
+				}
+			}
+
+
+			if(chSectionNames[i+1]==0)
+			{
+				break;
+			}
+		} 
+	}
+}
+
+/*该函数与saveAdaIpToFile唯一区别：会检查config.ini中的IP冲突，但是应该谨慎使用*/
+VOID updateFileIpFromAda(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	clearConflictIpInConfig(pAdaInfo, pIniPath);
+	saveAdaIpToFile(pAdaInfo, pIniPath);
+}
+
+VOID updataFileDnsFromAda(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	saveAdaDnsToFile(pAdaInfo, pIniPath);
+}
+
+DWORD updateFileInfo(ADAPTER_INFO * pAdaInfo, TCHAR *pIniPath)
+{
+	
+	TCHAR dhcpFileBuff[DHCP_LEN] = {0};
+	DWORD ret = SUCCESS_CODE;
+	BOOL adaDhcp = FALSE;
+	BOOL fileDhcp = FALSE;
+
+	readDhcpStatusFromFileByMac(pAdaInfo->mac, pIniPath, dhcpFileBuff);
+	fileDhcp = cmpStrIsEqual(dhcpFileBuff, DHCP_ON);
+
+	adaDhcp = cmpStrIsEqual(pAdaInfo->dhcpStatus, DHCP_ON);
+
+
+	if(adaDhcp && (!fileDhcp))/*如果是从DHCP获取IP，但配置文件不是，则更新文件*/
+		{
+		writeDhcpStatusToFileByMac(DHCP_ON, pAdaInfo->mac, pIniPath, NULL);
+		LogEvent(_T("[QGA]change file mac %s ip from dhcp "), pAdaInfo->mac);
+		}
+	else if((!adaDhcp) && fileDhcp) /*如果网卡不从DHCP获取，但配置文件是从DHCP获取,更新文件*/
+		{
+		updateFileIpFromAda(pAdaInfo, pIniPath);
+	}
+	else if((!adaDhcp)&&(!fileDhcp))/*如果网卡不从DHCP获取，配置文件也不是，对比IP是否相同决定是否更新文件*/
+	{
+		
+	//ip mask gateway不相等则更新File文件
+	if(!cmpIpInfoIsEqualWithFile(pAdaInfo,pIniPath))
+		updateFileIpFromAda(pAdaInfo, pIniPath);
+	}
+	//else //如果都是通过DHCP获取IP，则不需要更新文件IP(adaDhcp && fileDhcp)
+	//{
+		//LogEvent(_T("[QGA]mac %s ip and file all from dhcp, do nothing"), pAdaInfo->mac);
+	//}
+
+
+	//如果DNS不相等，则更新file文件
+	if(!cmpDnsInfoIsEqualWithFile(pAdaInfo, pIniPath))
+	{
+		updataFileDnsFromAda(pAdaInfo, pIniPath);
+	}
+
+	return ret;
+}
+
+DWORD updateConfigFile(std::vector<ADAPTER_INFO  *> &pNicInfoVec, TCHAR *pIniPath)
+{	
+	TCHAR ipBuff[IP_STR_LEN] = { 0 };
+	std::vector<ADAPTER_INFO *> infoList; 
+	DWORD ret = SUCCESS_CODE;
+
+	if(pNicInfoVec.size() != 0)
+	{
+		for(std::vector<ADAPTER_INFO *>::iterator iter=pNicInfoVec.begin(); iter!=pNicInfoVec.end(); iter++)
+		{
+			if(isMacExistInFile((*iter)->mac, pIniPath))
+			{
+				//更新配置文件里面的IP记录
+				updateFileInfo((*iter), pIniPath);
+			}
+			else
+			{
+				/*新发现的网卡，检查其继承的IP是否与现存网卡冲突*/
+				getIpFromAdaInfo(*iter, ipBuff);
+				if(checkIpConflict(*iter, ipBuff))
+				{
+					//如果其继承网卡与系统冲突，则删除其现在IP与DNS
+					LogEvent(_T("[QGA]new mac %s ip %s conflict with other nic , set ip dns from dhcp"), (*iter)->mac, ipBuff);
+					setAdaIpDnsFromDhcpSyncFile(*iter);
+				}
+				else
+				{
+					/*考虑使用saveAdaIpDnsToFile还是updateFileIpFromAda*/
+					saveAdaIpDnsToFile(*iter, pIniPath);
+				}
+			}
+				
+		}
+	}
+	return ret;
+}
+
+VOID setIniFilePath()
+{
+	GetModuleFileName(NULL, g_configPath, sizeof(g_configPath));
+	(_tcsrchr(g_configPath, _T('\\')))[1] = 0;
+	_tcscat(g_configPath, _T("config.ini"));
+       LogEvent(_T("[QAG] ini file %s %d"), g_configPath, MAC_LEN);
+}
+
+DWORD dealConfigFileByAdaInfo(std::vector<ADAPTER_INFO  *> & pAdaInfoVect)
+{
+	//DWORD dwRet = 0;
+	DWORD ret = SUCCESS_CODE;
+
+	if (FileExist(g_configPath))
+	{
+		ret = updateConfigFile(pAdaInfoVect, g_configPath);
+	}
+	else
+	{
+		saveNicInfo(pAdaInfoVect, g_configPath);
+	}
+
+	return ret ;
+}
+
+DWORD dealConfigFile(VOID)
+{
+	DWORD dwRet = 0;
+	DWORD ret = SUCCESS_CODE;
+
+	std::vector<ADAPTER_INFO  *> pAdaInfoVect;
+
+	if ((dwRet = GetNicInfo(pAdaInfoVect)) != ERROR_SUCCESS)
+	{
+		LogEvent(_T("[QGA]cannot get nic info."));
+		return dwRet;
+	}
+
+	if (FileExist(g_configPath))
+	{
+		ret = updateConfigFile(pAdaInfoVect, g_configPath);
+	}
+	else
+	{
+		saveNicInfo(pAdaInfoVect, g_configPath);
+	}
+
+	freeAdaInfoVec(pAdaInfoVect);
+
+	return ret ;
+
+}
+
+/*diff 应用了 first second 里面的空间，要在二者后面销毁*/
+VOID diffAdaVect(std::vector<ADAPTER_INFO  *> &first, std::vector<ADAPTER_INFO  *> &second, std::vector<ADA_DIFF_INFO> &diff)
+{
+	std::map<INT,ADAPTER_INFO *> first_index;
+	std::map<INT,ADAPTER_INFO *> second_index;
+
+	for(std::vector<ADAPTER_INFO *>::iterator iter=first.begin(); iter!=first.end(); iter++)
+	{
+		first_index[(*iter)->index] = (*iter);
+	}
+
+	for(std::vector<ADAPTER_INFO *>::iterator iter=second.begin(); iter!=second.end(); iter++)
+	{
+		second_index[(*iter)->index] = (*iter);
+	}
+
+	for(std::map<INT, ADAPTER_INFO *>::iterator iter=first_index.begin(); iter!=first_index.end(); iter++)
+	{
+		//如果二中没有，则认为是删除了的
+		if (second_index.end() == second_index.find((*iter).first))
+		{
+			ADA_DIFF_INFO tmp ;
+			tmp.addOrDel = DEL_NIC;
+			tmp.adaInfo = (*iter).second;
+			diff.push_back(tmp);
+		}
+	}
+
+	for(std::map<INT, ADAPTER_INFO *>::iterator iter=second_index.begin(); iter!=second_index.end(); iter++)
+	{
+		//如果一中没有，则认为是新增的
+		if (first_index.end() == first_index.find((*iter).first))
+		{
+			ADA_DIFF_INFO tmp ;
+			tmp.addOrDel = ADD_NIC;
+			tmp.adaInfo = (*iter).second;
+			diff.push_back(tmp);
+		}
+	}
+
+}
+//没有网卡ID的变多变少，只有ip事件发生，认定是IP变化；这里如果有时间，后续可以通过DIFF查找到更加详细的变化，精确到一块指定网卡
+VOID doIpChangeEvent(std::vector<ADAPTER_INFO  *> &currAdaVect)
+{
+	dealConfigFileByAdaInfo(currAdaVect);
+}
+
+VOID doNicChangeEvnet(std::vector<ADA_DIFF_INFO> & diffAdaVect)
+{
+	//处理网卡增加与删除的事件
+	for(std::vector<ADA_DIFF_INFO>::iterator iter=diffAdaVect.begin(); iter!=diffAdaVect.end(); iter++)
+	{
+		//处理网卡删除
+		if((*iter).addOrDel == DEL_NIC)
+		{
+			delRecordByMac((*iter).adaInfo->mac, g_configPath);
+			LogEvent(_T("[QGA]del mac %s record from config"), (*iter).adaInfo->mac);
+		}
+		else if((*iter).addOrDel == ADD_NIC) //处理网卡增加
+		{
+			//可以考虑封装一个函数，当前时间来不及了
+			if(isMacExistInFile((*iter).adaInfo->mac, g_configPath))
+			{
+				//
+				if(CONFLICT_CODE == updateAdaFromFile((*iter).adaInfo, g_configPath))
+				{
+					/*如果待恢复的IP，与当前系统向冲突，则直接从DHCP分配*/
+					LogEvent(_T("[QGA]new mac %s restore ip but conflict with other nic , set ip dns from dhcp"), (*iter).adaInfo->mac);
+					setAdaIpDnsFromDhcpSyncFile((*iter).adaInfo);
+				}
+			}
+			else
+			{
+				//这里要做的比较完善，还要检查网卡继承至注册表的IP是否冲突，但是这个不是IP恢复的功能，该问题是系统自身问题
+				/*新发现的网卡，检查其继承的IP是否与现存网卡冲突*/
+				TCHAR ipBuff[IP_STR_LEN] = {0};
+				getIpFromAdaInfo((*iter).adaInfo, ipBuff);
+				if(checkIpConflict((*iter).adaInfo, ipBuff))
+				{
+					//如果其继承网卡IP与系统冲突，则删除其现在IP与DNS
+					LogEvent(_T("[QGA]new mac %s ip %s conflict with other nic , set ip dns from dhcp"), (*iter).adaInfo->mac, ipBuff);
+					setAdaIpDnsFromDhcpSyncFile((*iter).adaInfo);
+				}
+				else
+				{
+					saveAdaIpDnsToFile((*iter).adaInfo, g_configPath);
+				}
+			}
+		}
+	}
+}
+
+DWORD WINAPI monitorThread (PVOID pParam)
+{
+	HANDLE hEvent[2];
+	INT nicCount = 0;
+	INT ipCount = 0;
+	INT timeOutCount = 0;
+	BOOL waitAlong = FALSE;
+	DWORD dwRet;
+	INT retryTimes = 0;
+
+	std::vector<ADAPTER_INFO  *> * pAdaInfoLastVect = new std::vector<ADAPTER_INFO  *> ();
+
+	if ((dwRet = GetNicInfo(*pAdaInfoLastVect)) != ERROR_SUCCESS)
+	{
+		LogEvent(_T("[QGA]cannot get nic info."));
+		return dwRet;
+	}
+	//进来就进行一次恢复，有存在的必要。
+	dwRet = restoreNicIp(*pAdaInfoLastVect);
+
+	/*如果restoreNicIp里面只做了保存文件的操作，那么没必要检查恢复成功与否*/
+	if(dwRet != NO_FILE_CODE)
+	{
+		while(retryTimes < RETRY_TIMES)
+		{
+			if(ERROR_SUCCESS == checkRestoreNicIpResult())
+			{
+				break;
+			}
+			Sleep(SLEEP_TIMES);
+			retryTimes++;
+		}
+	}
+	
+
+	hEvent[0]= CreateEvent(NULL, FALSE, FALSE, NULL);
+	hEvent[1]= CreateEvent(NULL, FALSE, FALSE, NULL);
+
+	DWORD dwFilter0 = REG_NOTIFY_CHANGE_NAME | REG_NOTIFY_CHANGE_ATTRIBUTES | REG_NOTIFY_CHANGE_LAST_SET;
+	DWORD dwFilter1 = REG_NOTIFY_CHANGE_NAME | REG_NOTIFY_CHANGE_ATTRIBUTES | REG_NOTIFY_CHANGE_LAST_SET;
+	HKEY hKey[2] = {NULL, NULL};
+
+	LogEvent(_T("[QGA]monitorThread start.\n"));
+
+	//打开键值
+	if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, NIC_CHANGE, 0, KEY_READ, &hKey[0]) != ERROR_SUCCESS)
+	{
+		LogEvent(_T("[QGA][monitorThread]:Open Register  failed.\n"));
+		return   ERROR_CODE;
+	}
+
+	if (RegOpenKeyEx(HKEY_LOCAL_MACHINE, IP_CHANGE, 0, KEY_READ, &hKey[1]) != ERROR_SUCCESS)
+	{
+		LogEvent(_T("[QGA][monitorThread]:Open Register  failed.\n"));
+		return   ERROR_CODE;
+	}
+
+	//监控某一项变化
+	while (TRUE)
+	{
+
+		if (::RegNotifyChangeKeyValue(hKey[0],
+			TRUE,
+			dwFilter0,
+			hEvent[0],
+			TRUE) != ERROR_SUCCESS)
+		{
+			LogEvent(_T("[QGA][monitorFileThread]:Watch NIC_CHANGE failed.\n"));
+			return   ERROR_CODE;
+		}
+
+		if (::RegNotifyChangeKeyValue(hKey[1],
+			TRUE,
+			dwFilter1,
+			hEvent[1],
+			TRUE) != ERROR_SUCCESS)
+		{
+			LogEvent(_T("[QGA][monitorFileThread]:Watch IP_CHANGE failed.\n"));
+			return   ERROR_CODE;
+		}
+
+		DWORD index = WaitForMultipleObjects(2, hEvent, FALSE, (waitAlong ? INFINITE: 1500));
+
+		/*当连续多个事件发生时，等待到没有事件发生的时刻才执行动作，做了一个延时判断机制*/
+		if(index == WAIT_OBJECT_0)
+		{
+			nicCount++;
+			waitAlong = FALSE;
+		}
+		else if(index == WAIT_OBJECT_0 + 1)
+		{
+			ipCount++;
+			waitAlong = FALSE;
+		}
+		else if (index == WAIT_TIMEOUT)
+		{
+
+			if((nicCount == 0) && (ipCount == 0))
+			{
+				timeOutCount++;
+				if(timeOutCount >= RETRY_TIMES)
+				{
+					timeOutCount = 0;
+					waitAlong = TRUE;
+					//LogEvent(_T("[QGA]:time out.\n"));
+				}
+				//这个是延时的关键,continue不能掉
+				continue;
+			}
+
+			//只有当网卡变化事件全部出来完毕后，才处理事件，考虑封装成一个函数，没有时间了
+			
+			std::vector<ADAPTER_INFO  *> * pAdaInfoVect = new std::vector<ADAPTER_INFO  *> ();
+
+			std::vector<ADA_DIFF_INFO> adaDiffInfoVect;
+
+			if ((dwRet = GetNicInfo((*pAdaInfoVect))) != ERROR_SUCCESS)
+			{
+				LogEvent(_T("[QGA]cannot get nic info."));
+				return dwRet;
+			}
+
+			diffAdaVect((*pAdaInfoLastVect), (*pAdaInfoVect), adaDiffInfoVect);
+
+
+			/*我们认为一个时刻，不会同时发生IP变化与网卡增删；
+			*单纯修改IP，不会触发网卡增删；而发生网卡增删，如果没触发IP修改，也没问题；如果网卡增删触发了IP修改，则后续流程会自动触发IP事件；故每次只
+			处理一种事件，简化流程*/
+			if((ipCount > 0) && adaDiffInfoVect.empty())
+			{
+				doIpChangeEvent(*pAdaInfoVect);
+			}
+			else if(!adaDiffInfoVect.empty())
+			{
+				doNicChangeEvnet(adaDiffInfoVect);
+			}
+
+
+			//释放先前的内存，最后一个元素不会释放，等待进程自动结束
+			freeAdaInfoVec((*pAdaInfoLastVect));
+			free(pAdaInfoLastVect);
+
+			pAdaInfoLastVect = pAdaInfoVect;
+
+			timeOutCount = 0;
+			waitAlong = FALSE;
+			nicCount = 0;
+			ipCount = 0;
+
+		}
+		else
+		{
+			LogEvent(_T("[QGA]:default changed, change error %d\n"), index);
+		}
+	}
+
+	LogEvent(_T("[QGA]watching monitorFileThread ...end"));
+
+	return SUCCESS_CODE;
+}
+
+extern "C" VOID ipMonitorInit(VOID); 
+
+VOID allocatePreMem(VOID)
+{
+	g_preMem = new TCHAR[MAX_PREBUFF_LEN];
+	if(g_preMem == NULL)
+	{
+		LogEvent(_T("[QGA]allocatePreMem failed "));
+		_exit(ERROR_CODE);
+	}
+}
+
+VOID ipMonitorInit(VOID)
+{
+    HANDLE hThreadWatch;
+    setOSversion();
+
+    /*no suitable for xp*/
+    if(!g_VistaOrLater)
+         return;
+
+    setIniFilePath();
+	//预先分配一块全局内存，后续连续使用，没有回收机会
+	allocatePreMem();
+    
+    hThreadWatch = CreateThread(NULL, 0, monitorThread, NULL, 0, NULL);
+    if (hThreadWatch == NULL)
+    {
+        LogEvent(_T("[QGA]Create monitorIpThread failed"));
+        _exit(1);
+    }
+    CloseHandle(hThreadWatch);
+    
+    LogEvent(_T("[QGA]create thread to monitorIP success"));
+}
+
+/*
+int _tmain(int argc, _TCHAR* argv[])
+{
+	ipMonitorInit();
+
+	_tsystem(_T("pause"));
+	return 0;
+}*/
+
-- 
1.8.3.1
